require_relative 'log_analyzer'

describe LteLogAnalyzer, 'default' do
  before :all do
    @lteLog = LteLogAnalyzer.new
  end
  it "outputs an abstract"
  it "lists reject or failure messages"
  it "buffers likeness messages"
  it "shows nas procedures"
  it "shows radio links"
  it "shows idle"
  

	
	it "should register" do
		# online & offline chart
		@lteLog.nas.esm		#show eps bearers
		@ltelog.nas.emm		#show tracking area actions
	end
	
	it "should show rrc idle" do
		rrc_idle = @lteLog.rrc.idle		#cell selection and reselection
	end
	
	it "should show rrc connection" do 
		rrc_conn = @lteLog.rrc.conn
	end
	
	it "should list measurement" do
		meas = @lteLog.rrc.meas
	end

	it "should irat" do
	end		
  
  it "should show csfb"	do
  	@lteLog.csfb
  end
end

describe LteLogAnalyzer, 'logs' do
	it "supports enumerable"
	it "outputs a report"
end
