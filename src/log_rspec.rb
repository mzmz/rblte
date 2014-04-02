require_relative 'log'
require 'easy_diff'
require 'test/unit'

describe Log, 'default' do
  before :all do
    @log = Log.new('../logs/121log0.txt')
		@ary = @log.ex_msg(/cellSelectionInfo/)
		@bry = @log.ex_msg(/emm_ta_update_req/)
  end
  
  it "parse the log file to raw items" do 
  	@log.rawi.should be_a(Array)
  	# @log.rawi.size.should equal(4)
  end

	it "includes log items" do
		@log.msg.size.should equal(307)
	end

	it "could extract specific messages" do
		@ary.size.should equal(15)
		@bry.size.should equal(5)
	end
	it "could merge and sort messages" do
		a = [@bry, @ary].flatten
		a.sort! {|x, y| x['time'] <=> y['time']}
		at = a.shift
		a.each {|x| at['time'].should < x['time']; (x['time'].to_time-at['time'].to_time); at = x}
	end



	it "refine diff result" do

		ah = {"emm_ta_update_req"=>
		{"nas_key_set_id_asme"=>"3 (0x3)",
		 "old_guti"=>
		  {"MME_code"=>"133 (0x85)",
		   "m_tmsi"=>"3808555940 (0xe301f3a4)",
		   "gprs_cipher_key"=>
		    {"old_p_tmsi_sig"=>
		      {"p_tmsi_sig_val"=>{},
		       "additional_guti"=>
		        {"m_tmsi"=>"3557139963 (0xd405a5fb)",
		         "nounce"=>"2885642120 (0xabff6788)",
		         "ue_netwk_cap"=>
		          {"last_visited_reg_tai"=>
		            {"mcc_mnc"=>
		              {"drx_params"=>
		                {"eps_bearer_context_status"=>{"ms_netwk_cap"=>{}}}}}}}}}}}}
		#pp ah.to_s.size
		 ah.deep_del_nil!
		ah.to_s.size.should == 270
	end
=begin
=end  
  it "includes message definitions set" 
  

  it "locates a message by id"
	#it "diff 2 messages"
  it "travels forword"
  it "travels backword"
  	
  	
  it "should browse a message interactively" do
  end

  
	  
  
end

describe Log, 'logs' do
	it "gets log items from a log file" do
		#lteLog = 
  	#refute_empty()
  end
end
