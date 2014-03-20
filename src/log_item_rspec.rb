
require_relative 'log_item'

describe LogItem do
  before :all do
  	a_rrc_log = []
  	File.open('../workspace/rrc_log_1') do |f|
  		f.each do |li|
  			a_rrc_log << li
  		end
  	end
  	pp a_rrc_log
    @lteMessage = LogItem.new(a_rrc_log, 'rrc')

  	a_nas_log = []
  	File.open('../workspace/nas_log_1') do |f|
  		f.each do |li|
  			a_nas_log << li
  		end
  	end
		p '---------------NAS-----------------------'
		pp a_nas_log
		@lteMessage.loaf_idtlog(a_nas_log)
  end

  it "checks fields and values of an item according to the message definition"
  
  it "map an log item to message"
  it "should diff log item and message definition"
  it "should"
end

