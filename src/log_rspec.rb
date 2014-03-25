require_relative 'log'

describe Log, 'default' do
  before :all do
    @log = Log.new('../logs/121log0.txt')
  end
  
  it "parse the log file to raw items" do 
  	@log.rawi.should be_a(Array)
  	# @log.rawi.size.should equal(4)
  end

	it "includes log items" do
		@log.msg.size.should equal(307)
	end

	it "could extract specific messages" do
		#pp @log.ex_msg("rrcConnectionSetup")
		#p '-------------------------------'
		ary = @log.ex_msg(/cellSelectionInfo/)
		bry = @log.ex_msg(/emm_ta_update_req/)
		ary.size.should equal(15)
		bry.size.should equal(5)
		a = [bry, ary].flatten
		a.sort! {|x, y| x['time'] <=> y['time']}
		a.each {|x| pp x['time']}
	end
  
  it "includes message definitions set" do		
  	#assert_instance_of(LteSigDef, lteLog.msg_def)
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
