require_relative 'io_file'

class MsgDef
	include IoFile
	attr_reader :asn
	
<<-MSG_DEF_EXAMPLE
DRB-CountMSB-InfoList ::=		SEQUENCE (SIZE (1..maxDRB)) OF DRB-CountMSB-Info

DRB-CountMSB-Info ::=	SEQUENCE {
	drb-Identity					DRB-Identity,
	countMSB-Uplink					INTEGER(0..33554431),
	countMSB-Downlink				INTEGER(0..33554431)
}
DRB-Identity ::=					INTEGER (1..32)
-------------------------------------->
amsg_hash = 
	{
		DRB-CountMSB-InfoList => 		[	SEQUENCE (SIZE (1..maxDRB)) =>	[DRB-CountMSB-Info	REF] ]
		DRB-CountMSB-Info => [	SEQUENCE
			[	drb-Identity =>	[	DRB-Identity	=> INTEGER (1..32)	]
				countMSB-Uplink	=>	INTEGER(0..33554431)
				countMSB-Downlink	=>INTEGER(0..33554431)
			]
	]
	}
MSG_DEF_EXAMPLE

	@@asn_delim = /::=/
	def initialize(file = '../workspace/36331-c00-asn')		#'../workspace/TS24301Msgs.asn'
			@asn = file2items(file, @@asn_delim )
			@msgs = {}
			@asn.each do |item|
				item_asn(item, @msgs)
			end
				
	end
	
	def item_asn(la, amsg = {})				#msg is to put into a hash	
		if la[0] =~ /(.*)::=(.*)/
			#key is a left value (the string before '::=')
			#def is a right value (the string after '::=' and the following lines)
			amsg[key = $1.strip] = [$2]			
			
			la.shift					
			la.each do |li|
				li.each do |pair_li|
					a_pair = pair_li.split 
					if not a_pair.empty?			#
						amsg[key] << a_pair
					end
        end
      end
    end
	end
	
	
	
  def items2mtc(items)
    mtc = {}

    items.each do |item|
      #name TYPE {content}, 
      #a_msg = {name => [TYPE, [en], {dc}]}
      p head = item.shift
      if  head =~ /::=/
        p 'name  ' + name = $`.strip
        p 'type  ' + type = $'.split.join(' ')

        if type.include?('{')
          mtc[name] = [type, ary1 = embed(item, ary1=[])]
        else
          mtc[name] = type
        end
      end
    end
    pp '--------mtc------------'    
    pp 
    mtc
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
      elsif l =~ /([\w\-]+)\s(.*)\s{$/
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
