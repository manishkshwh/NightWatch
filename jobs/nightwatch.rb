class Nightwatch
	attr_accessor :urls

	def initialize
		@state = "rotateClockwise"
		@urls = Array.new()
		@active = true
	end

	def rotateClockwise
		@urls << @urls.first		
		@urls.shift			
	end

	def randomChange
		@urls = @urls.shuffle
	end

	def nextMove
		if @active
			eval("#{@state}()") 
		end
	end

	def newUrl(url)
		@urls << url
	end

end

class NightWatchEngage
	
	theList = Nightwatch.new

	SCHEDULER.every '30s', :first_in => 0 do |job|
	  theList.nextMove
	  send_event('nightwatch', {urls: theList.urls})
	end

end

NightWatchEngage.new
