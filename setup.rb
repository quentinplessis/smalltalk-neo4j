
if ARGV.size <= 0
	puts 'ruby setup.rb [start|stop]'
	abort
end

action = ARGV[0]

if action == 'start'
	# Launch neo4j
	data_folder = File.join(Dir.pwd, 'neo4j-data').sub('C:', '/c')
	command = "docker run -p 7474:7474 -p 7687:7687 -v \"#{data_folder}\":/data --name neo4j -d neo4j:3.2.3"
	puts command
	system command
	
elsif action == 'stop'
	command = 'docker rm -f neo4j'
	puts command
	system command
end
