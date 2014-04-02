require_relative 'log_analyzer'

describe LteLogAnalyzer, 'default' do
  before :all do
    @lteA = LteLogAnalyzer.new('../logs/121log0.txt')
  end
  it "outputs an abstract" 	
	it "static message types in the log" do
		# pp 
		@lteA.msg_types
	end
  it "lists reject or failure messages" do
		pp @lteA.filter_rej#(/complete/)
	end
  it "buffers likeness messages"
  it "shows nas procedures"
  it "shows radio links"
  it "shows idle"
  

	
	it "should register" do
		# online & offline chart
		@lteA.nas.esm		#show eps bearers
		@lteA.nas.emm		#show tracking area actions
	end
	
	it "should show rrc idle" do
		rrc_idle = @lteA.rrc.idle		#cell selection and reselection
	end
	
	it "should show rrc connection" do 
		rrc_conn = @lteA.rrc.conn
	end
	
	it "should list measurement" do
		meas = @lteA.rrc.meas
	end

	it "should irat" do
	end		
  
  it "should show csfb"	do
  	@lteA.csfb
  end
end

describe LteLogAnalyzer, 'logs' do
	it "supports enumerable"
	it "outputs a report"
end
