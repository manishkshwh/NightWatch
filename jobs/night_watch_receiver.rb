if !File.directory? 'lib'
	Dir.mkdir('lib')
end

if !File.directory? 'lib/nightwatch' 
	Dir.mkdir('lib/nightwatch')
end
if !File.exists? 'lib/nightwatch/state.txt'
	a = File.new('lib/nightwatch/state.txt', 'w')
	a.close
end
if !File.exists? 'lib/nightwatch/urls.txt'
	a = File.new('lib/nightwatch/urls.txt', 'w')
	a.close
end

get '/addUrl/:url' do
	puts "test: #{params[:url]}"
	urlFile = File.open("lib/nightwatch/urls.txt", "a")
		urlFile.syswrite("#{params[:url]}\r\n")
	urlFile.close
end

get '/removeUrl/:url' do
	puts "test remove: #{params[:url]}"
	# read the list into an array
	# remove the url from the arry, if it exists
	# write the new array to the list file
	urls = IO.readlines('lib/nightwatch/urls.txt')
	urls.delete("#{params[:url]}\r\n")
	writeString = ""
	urls.each { |e| writeString << "#{e}\r\n" }

	urlFile = File.open("lib/nightwatch/urls.txt", "w")
		urlFile.syswrite(writeString)
	urlFile.close

end

get '/alterState/:state' do
	puts "test new state: #{params[:state]}"
	# screw checking if the file exists, just overwrite the state to /lib/nightwatch/state.txt
	# only take the first word in the url - we don't want to eval just anything
	
	newState = params[:state].split(" ").first
	
	stateFile = File.open("lib/nightwatch/state.txt", "w") 
		stateFile.syswrite(newState)
	stateFile.close

end
