require_relative 'io_file'
require_relative 'msg_def'
require_relative 'log_item'

class Log
	include IoFile
	
	attr_reader :rawi, :msg
	@@log_line_1 = /(.*)\[00\]\s*(0x\w{4})/

	def initialize(file = '../logs/ex_log')
		@rawi = file2items(file, @@log_line_1)
		@msg = []
		@rawi.each do |it|
			ait = LogItem.new(it)
			@msg << ait if ait.instance_variable_defined?(:@hd)
		end
		
	end

	#extract messages according to the input regex
	def ex_msg(pt)
		pt_ary = []
		@msg.each do |ait|
			#ax = ait.get_kys(ait.ah)
			#if ax.include?(pt)
				#pp	'!' 
				aex = ait.get_node(ait.ah, pt)
				if not aex.empty?	
					aex[0]['time'] = ait.hd['time']
					pt_ary << aex
				end
			#end
		end
		pt_ary.flatten
	end

	#sort according to time
	def sort(ary)
		
	end

end
