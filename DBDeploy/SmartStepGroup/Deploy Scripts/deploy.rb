Server = ARGV[0]
DB = ARGV[1]
Login = ARGV[2]
Password = ARGV[3]

def main()
	system "color 0A"

	puts "Deploying " + DB + "\n\n"
	
	createDatabase
	createChangeLogTable
	deploySchemaChanges
	
	# deploy "Views"
    # deploy "Functions"
    # deploy "Stored Procedures"
    # deploy "Triggers"

	create "Post Deployment Scripts"
                             
	puts "Deployment to #{Server}\\#{DB} successfully completed"
end

def credentials
	Login == nil ? "-E" : "-U #{Login} -P #{Password}"
end

def createDatabase()
	fail if not system "sqlcmd -S #{Server} #{credentials} -b -i \"Deploy Scripts/SQL/Database.sql\" -v db=#{DB}"
end

def createChangeLogTable()
	execute("Deploy Scripts/SQL/Create Change Log Table.sql")
end

def deploySchemaChanges()
	currentVersion = execute("DECLARE @v varchar(100) SELECT @v = MAX(chg_seq_nbr) FROM db_chg_log PRINT @v")
	puts "Current DB Version: #{currentVersion}"

	Dir["Schema Changes/**/*.sql"].sort.each { |changeScript|
		changeNumber = File.basename(changeScript, ".sql")
		
		alreadyApplied = execute("IF EXISTS (SELECT NULL FROM db_chg_log WHERE chg_seq_nbr='#{changeNumber}') PRINT 'Yes' ELSE PRINT 'No'")
			
		if (alreadyApplied.strip == "No") 
			puts "Updating to version: #{changeNumber}"
			execute(changeScript)
			execute("INSERT INTO db_chg_log (chg_seq_nbr) VALUES('#{changeNumber}')")
		end
	}
end

def deploy(objectsType)
	puts "Deploying #{objectsType}"
	
	drop objectsType
	create objectsType
end

def create(objectsType)
	Dir["#{objectsType}/**/*.sql"].sort.each { |filePath|
		puts File.basename(filePath)
		fail if not system "sqlcmd -S #{Server} -d #{DB} #{credentials} -b -i \"#{filePath}\""
	}
end

def drop(objectsType)
	fail if not system "sqlcmd -S #{Server} -d #{DB} #{credentials} -b -i \"Deploy Scripts/SQL/drop #{objectsType}.sql\""
end

def execute(query)
	if (File.exists?(query))
		script = File.open(query, "r:UTF-8") { |f|
			c = f.getc
			if (c != "\uFEFF") then f.ungetc c end

			f.read
		}
		
		tempScript = File.open("Deploy Scripts/temp.sql", "w+:UTF-8")
		tempScript.write "SET XACT_ABORT ON BEGIN TRANSACTION #{script} COMMIT".force_encoding("UTF-8")
		tempScript.close

		fail if not system "sqlcmd -S #{Server} #{credentials} -d #{DB} -f i:65001,o:866 -b -i \"Deploy Scripts/temp.sql\""
	else
		io = IO.popen "sqlcmd -S #{Server} -d #{DB} #{credentials} -Q \"#{query}\""
		io.readlines[-1] # last line
	end
end

def fail
	system "color 0C"
	exit(1)
end

main()