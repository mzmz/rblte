require_relative 'msg_def'

describe MsgDef do
	before :all do
		@msg_def = MsgDef.new
	end
	
	it 'gets asn from files' do
		@msg_def.asn.should be_kind_of(Array)
		@msg_def.msgs.should be_kind_of(Hash)
	end
	
  it "includes all message definitions in in ts36.331 and ts24.301"
  it "lists the message tree"
end
