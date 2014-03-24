require 'pp'

module IoFile
	
	#split a file to definition blocks
	def file2items(file, marking)
		items = []
		File.open(file, "r") do |f|
			item = []
			f.each do |fline|
				if marking.match(fline)
					items << item	unless item.empty?
					item = []
				end
				#yield fline if block_given?
				#fline.gsub!(/--.*/,'')		#omit comment in asn file
				mli = fline.split(/[,\|]/)
				mli.each do |li|
					li.strip!
					item << li unless li.empty?
				end
			end
			items << item unless item.empty? 
		end
	end
	
	
	def embed(item, ary)
    dc = {}
    en = []
    while !item.empty? do 
      rl = item.shift
      l = rl.split.join(' ')
      l.sub!(/--.*/, '')     #delete the comment
      
      if l =~ /^}/    
        return ary << dc << en
      elsif l =~ /([\w\-]+)\s(.*)\s{$/		#online "{"
        ary << {$1 => [$2]}
        #p $1 + '=======>>>>>' + $2
        cursor  = ary.last[$1]
        embed(item, cursor)
      elsif    (al = l.split(/\s,\s/)).length > 2       #ENUMERATED
        en = en | al
      elsif /\s+([\w\-]+),*$/.match(l)    #a name-type pair
        name = $`
        type = $1
        dc[name] = type        
      end
    end
  end
		
	
end
