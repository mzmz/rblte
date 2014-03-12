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
		DRB-CountMSB-InfoList => 		[	SEQUENCE (SIZE (1..maxDRB)) [	DRB-CountMSB-Info => SEQUENCE	]	]
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
		
end
