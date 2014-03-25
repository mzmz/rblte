class LogItem


<<-LOG_ITEM_EXAMPLE
2013 Jul 11  13:47:37.941  [00]  0xB0C0  LTE RRC OTA Packet  --  UL_CCCH
Pkt Version = 2
RRC Release Number.Major.minor = 9.10.0
Radio Bearer ID = 0, 
Physical Cell ID = 105
Freq = 38350
SysFrameNum = N/A, 
SubFrameNum = 0
PDU Number = UL_CCCH Message,    
Msg Length = 6

Interpreted PDU:

value UL-CCCH-Message ::= 
{
  message c1 : rrcConnectionRequest : 
      {
        criticalExtensions rrcConnectionRequest-r8 : 
          {
            ue-Identity randomValue : '00111000 00101000 01010100 01101010 11101111'B,
            establishmentCause mo-Signalling,		
            spare '0'B
          }
      }
}
--------------------------------->
amsg = {
UL-CCCH-Message =>
{
	rrcConnectionRequest =>
	{
		rrcConnectionRequest-r8 =>
		{
			ue-Identity => 	{	randomValue => '00111000 00101000 01010100 01101010 11101111'B },
			establishmentCause => 	mo-Signalling,
			spare => '0'B
		}
	}
}
LOG_ITEM_EXAMPLE


attr_reader :hd, :ah, :ax		#:hd - log header; ah - message body

#get an message hash from an QXDM log block
def initialize(loaf)
	hd = loaf_head(loaf)
	if hd.empty?
		return nil
	else
		@hd = hd
		if @hd['cmt'].include?('RRC')
			loaf_brlog(loaf) 
		elsif @hd['cmt'].include?('NAS')
			loaf_idtlog(loaf)
		else		#
			p '-----------------------------------------'
			#@alog = nil
		end
		#pp hd
		#pp @ah
		#@ax = flat(ah)
	end
end

#get the regex pt matching field
def get_node(ah, pt)
	a = []
	ah.keys.each do |ky| 
		v = ah[ky]
		if pt.match(ky)		
			#pp 
			a << {ky => v} 
		elsif v.is_a?(Hash)
			a << get_node(v, pt)
		end
	end
	a.flatten
end

#extract all field name in a message
def get_kys(ah)
	ax = []
	ah.keys.each do |ky| 
		v = ah[ky]
		if v.is_a?(Hash)		
			ax << ky
			ax << get_kys(v)
		end
	end
	ax.flatten
end

#get the log info
def loaf_head(loaf)
	hd = {}
	while li=loaf.shift do 
		#p 'li---' + li
    if /(.*)\[00\]\s*(0x\w{4})\s*LTE(.*)--\s*(.*)/.match(li)    
      hd = { 'time' => DateTime.parse($1), 'qxdm_id' => $2, 'cmt' => $3.strip, 'cmt1' =>$4 }
    elsif /^([\w\. ]+)\s*=\s*(.+)$/.match(li)
			hd[$1.strip] = $2
		else
			loaf.unshift(li) if /^[-\w]+$/.match(li)
			return hd 
		end
	end
	hd
end

#parse an rrc log item
def loaf_brlog(loaf)
	#pp loaf
	@ah = {}
	while li=loaf.shift# do |li| 
		#p li + '---------------------------1'
		if /([\w\-]+)\s*:(:=)?\s*$/.match(li)	# the structure starts from like "name :"
			ky = $1
		end
		if li.include?('{')													
			#pp 
			@ah[ky] = em_brlog(loaf)
		end
	end	
end
def em_brlog(loaf)
	bh = {}
	while	li = loaf.shift 
		#p li + '---------------------------2'
		if /([\w\-]+)\s*:(:=)?\s*$/.match(li)	or /^\s*([-\w]+),?\s*$/.match(li)
			ky = $1			
		end
		if li.include?('{') #and ky
			bh[ky] = em_brlog(loaf)
		end
		if /([\w\-]+)/.match(li)		#TODO: fine the regex
			bh[$1] = $'.strip #+ '***'
		end
		if li.include?('}')	
			#p 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
			#pp bh
			return bh
		end
	end

end
=begin
<<-COMMET				


COMMET
=end		
<<-LOG_ITEM_NAS

2013 Jul 22  15:35:50.038  [00]  0xB0ED  LTE NAS EMM Plain OTA Outgoing Message  --  Detach request Msg
pkt_version = 1 (0x1)
rel_number = 9 (0x9)
rel_version_major = 5 (0x5)
rel_version_minor = 0 (0x0)
security_header_or_skip_ind = 0 (0x0)
prot_disc = 7 (0x7) (EPS mobility management messages)
msg_type = 69 (0x45) (Detach request)
lte_emm_msg
  emm_detach_request
    tsc = 0 (0x0) (cached sec context)
    nas_key_set_id = 4 (0x4)
    switch_off = 0 (0x0) (normal detach)
    detach_type = 3 (0x3) (combined EPS/IMSI detach)
    eps_mob_id
      id_type = 6 (0x6) (GUTI)
      odd_even_ind = 0 (0x0)
      Guti_1111 = 15 (0xf)
      mcc_1 = 4 (0x4)
      mcc_2 = 6 (0x6)
      mcc_3 = 0 (0x0)
      mnc_3 = 15 (0xf)
      mnc_1 = 0 (0x0)
      mnc_2 = 0 (0x0)
      MME_group_id = 416 (0x1a0)
      MME_code = 144 (0x90)
      m_tmsi = 3372550745 (0xc9050a59)
--------------------------------->
amsg = {
lte_emm_msg	=> {
  emm_detach_request => {
    tsc => 0 (0x0) (cached sec context)
    nas_key_set_id => 4 (0x4)
    switch_off => 0 (0x0) (normal detach)
    detach_type => 3 (0x3) (combined EPS/IMSI detach)
    eps_mob_id => {
      id_type => 6 (0x6) (GUTI)
      odd_even_ind => 0 (0x0)
      Guti_1111 => 15 (0xf)
      mcc_1 => 4 (0x4)
      mcc_2 => 6 (0x6)
      mcc_3 => 0 (0x0)
      mnc_3 => 15 (0xf)
      mnc_1 => 0 (0x0)
      mnc_2 => 0 (0x0)
      MME_group_id => 416 (0x1a0)
      MME_code => 144 (0x90)
      m_tmsi => 3372550745 (0xc9050a59)
      }
    }
  }
}  
LOG_ITEM_NAS

	#parse an nas log
	def loaf_idtlog(loaf)   
		@ah = {}
		idt0 = idt = 0
		while li = loaf.shift do
			if /^(\s*)(\w+)\s*$/.match(li)
				idt = $1.size
				idt0 = idt
				@ah[ky = $2] = em_idtlog(loaf, idt0)
			end
		end
	end

	def em_idtlog(loaf, idt0)
		bh = {}
		while li = loaf.shift do 				
			#p li + '---------------------------'
			if /^(\s*)(\w+)\s*$/.match(li)			
				idt = $1.size		
				bh[ky = $2] = em_idtlog(loaf, idt)			
			elsif /^(\s*)(\w+)\s*=\s*(.*)\s*/.match(li)
				idt = $1.size
				bh[ky = $2] = $3
			else
				#pp bh
				return bh			
			end

			idt0 = idt
		end
		return bh
	end  

	private :em_idtlog, :em_brlog
end
