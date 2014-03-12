require_relative 'io_file'
require_relative 'msg_def'
require_relative 'log_item'

class Log < LogItem
	include IoFile
	
	attr_reader :rawi
	
	@@log_line_1 = /(.*)\[00\]\s*(0x\w{4})\s(.*)/
	def initialize(file = '../logs/ex_log')
		@rawi = file2items(file, @@log_line_1)
	end
end