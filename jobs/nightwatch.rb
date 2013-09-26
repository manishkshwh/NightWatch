class NightWatch

	def initialize
		@urls = Array.new
		@state = ""
	end

	def rotate
		@urls << @urls.first		
		@urls.shift			
		writeUrls
	end

	def shuffle
		@urls = @urls.shuffle
		writeUrls
	end

	def freeze
		#do nothing
	end

	def nextMove
		getInfo
		if @state == "rotate" or @state == "shuffle" or @state == "freeze"
			eval("#{@state}()") 
		else
			#puts "Invalid state found. Rotating."
			rotate
		end
	end

	def writeUrls
		writeString = ""
		@urls.each { |e| writeString << "#{e}" }	
		a = File.open('lib/nightwatch/urls.txt', 'w')
			a.syswrite(writeString)
		a.close
	end

	def getInfo
		@state = IO.readlines('lib/nightwatch/state.txt').first
		@urls = IO.readlines('lib/nightwatch/urls.txt')
	end

	def delimitedUrls
		return @urls
	end

end

class NightWatchEngage
	theList = NightWatch.new

	SCHEDULER.every '15s', :first_in => 0 do |job|
	  theList.nextMove
	  send_event('nightwatch', length: theList.delimitedUrls.length)
	  puts theList.delimitedUrls.first
	end

end

load 'jobs/night_watch_receiver.rb'
NightWatchEngage.new
