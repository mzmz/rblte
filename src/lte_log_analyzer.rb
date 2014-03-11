require_relative 'lte_log'
require 'pp'

class LteLogAnalyzer
	attr_reader :mark, :msgs, :proc
	@@proc = {
		si: %w{ MasterInformationBlock SystemInformationBlockType1 SystemInformationBlock },
		cc: %w{ Paging 
		RRCConnectionRequest RRCConnectionSetup RRCConnectionSetupComplete RRCConnectionReject
		SecurityModeCommand SecurityModeComplete SecurityModeFailure
		RRCConnectionReconfiguration RRCConnectionReconfigurationComplete
		CounterCheck CounterCheckResponse
		RRCConnectionReestablishmentRequest RRCConnectionReestablishment RRCConnectionReestablishmentComplete RRCConnectionReestablishmentReject
		RRCConnectionRelease
		ProximityIndication }, 
		meas: %w{RRCConnectionReconfiguration},
		irat: %w{
		RRCConnectionReconfiguration RRCConnectionReconfigurationComplete
		MobilityFromEUTRACommand
		HandoverFromEUTRAPreparationRequest ULHandoverPreparationTransfer		}
		}
		
	def initialize(file = 'ex_log', description = 'an example for QXDM log file')
		@mark = file + ': ' + description
		@msgs = []#file2msgs(file)
		#@abstract = survey(@msgs)
		
		if msgs.empty?
			#raise 'empty log...'
		end
	end

	def msg_types(msgs)
		@msg_types = Hash.new(0)
		@msgs.each do |msg|
			msg.tag.each do |msg_tag|
				@msg_types[msg_tag] += 1
			end
		end
	end
		
	def filter(msgs)
		kinda_msgs = []
		@msgs.each do |msg|
			kinda_msgs << msg if yield
		end
	end
		
	def pact(msgs, procedure)
	
	end
	
	def afunc
	end
end
