require_relative 'log'

describe Log, 'default' do
  before :all do
    @log = Log.new
  end
  
  it "parse the log file to raw items" do 
  	@log.rawi.should be_a(Array)
  	pp @log.rawi.size.should equal(4)
  end
  
  it "includes message definitions set" do
  	assert_instance_of(LteSigDef, lteLog.msg_def)
  end
  
  it "contructs a 'nlog' array of messages" do
  	nlog = @lteLog.nlog
  	assert_instance_of(Array, nlog)
  	assert_equal(nlog.size, NLOG)
  	nlog.map { |msg| assert_instance_of(LteMsg, msg) }
  end

  it "locates a message by id"
  it "travels forword"
  it "travels backword"
  	
  	
  it "should browse a message interactively" do
  end

  
  it "should classify and merge all messages" do
  	msg_types = @lteLog.abstract.msg_types
  	msgs = []
  	msg_types.each do |msg_type|
			msgs << kinda_msg = @lteLog.call(msg_type)
			kinda_msg.each do |msg|
				check_msg(msg, msg_type)
			end
		end
		
		restuctured_log = LteLogAanayzer(msgs)
		#assert that restructed_log and @ltelog has the same message sequence
	end
  	  
  
end

describe Log, 'logs' do
	it "gets log items from a log file" do
		#lteLog = 
  	#refute_empty()
  end
end
