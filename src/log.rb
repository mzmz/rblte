require_relative 'io_file'
require_relative 'msg_def'
require_relative 'log_item'

class Hash
  def deep_del_nil!
    self.each_key do |k| 
			if self[k].is_a?(Hash)
				self[k].deep_del_nil!
			end
		end		
		self.delete_if {|k,v| v.empty?}
  end
end

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
		pts = $1 if /:(\w+)/.match("#{pt}")
		pt_ary.flatten!
	end

end
