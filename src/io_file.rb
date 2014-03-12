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
				fline.gsub!(/--.*/,'')
				mli = fline.split(/[,\|]/)
				mli.each do |li|
					li.strip!
					item << li unless li.empty?
				end
			end
			items << item unless item.empty? 
		end
	end
	
end
