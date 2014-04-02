require_relative 'log'


class LteLogAnalyzer
	attr_reader :mark, :msgs, :p, :msg_types
	@@p = {
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
		@msgs = @log = Log.new(file)
				
		if @log.msg.empty?
			#raise 'empty log...'
		end

		@msg_types = statis_types
	end

	def statis_types()
		msg_types = Hash.new(0)
		logitems = @log.msg
		logitems.each do |msg|
			msg.ax.each do |axi|
				msg_types[axi] += 1
			end
			#pp
		end
		msg_types.sort_by {|k, v| v}.reverse.to_h
	end
		
	def filter_rej(rej=/(rej)|(fail)/)
		kys = @msg_types.keys
		flts = {}

		kys.each do |k|
			puts k || rej
			if rej.match(k)
				puts '.........................'
				flts[k] = @msgs.ex_msg(Regexp.new(k))
			end
		end

		flts
	end
		
	def pact(msgs, procedure)
	
	end
	
	def afunc
	end
end
