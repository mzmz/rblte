
require_relative 'log_item'

describe LogItem do


  before :all do
arrc = 
'2013 Jul 11  13:47:37.941  [00]  0xB0C0  LTE RRC OTA Packet  --  UL_CCCH
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
            ue-Identity randomValue : \'00111000 00101000 01010100 01101010 11101111\'B,
            establishmentCause mo-Signalling,		
            spare \'0\'B
          }
      }
}'
anas=
'2013 Jul 22  15:35:50.038  [00]  0xB0ED  LTE NAS EMM Plain OTA Outgoing Message  --  Detach request Msg
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
      m_tmsi = 3372550745 (0xc9050a59)'

@arrc = arrc.split("\n")
@anas = anas.split("\n")
  end

  
  it "should map an rrc log item to message" do 
		log_item = LogItem.new(@arrc)
		#assert_kind_of(log_item.hd, Hash)
		pp log_item.hd
		pp log_item.ah
	end
		
	it "map an nas log item to message" do 
		log_item = LogItem.new(@anas)
		pp log_item.hd
		pp log_item.ah
		#assert(true)
	end
  it "checks fields and values of an item according to the message definition"
  it "diff log item and message definition"
  it ""
end

