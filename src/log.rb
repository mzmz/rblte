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

	def self.get_msg(type)
		define_method(type) {

		}
	end
end
