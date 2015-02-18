#!/bin/env ruby
require 'sqlite3'
require 'socket'
$dirpath = File.expand_path(File.dirname(__FILE__))
$dbFileName = "rubyCounter.sqlite"

class Counter
  attr_accessor :name
  attr_reader :startDateTime
  attr_reader :currentDateTime
  attr_reader :updateInterval
  
  def initialize(filename, interval=60)
    if filename != "fork"
      if !FileTest.exists?(File.join($dirpath,$dbFileName))
        @db = SQLite3::Database.new($dbFileName)
        @db.execute("CREATE TABLE counter(start TEXT, end TEXT, seconds UNSIGNED BIG INT, timestring TEXT);")
      else
        @db = SQLite3::Database.new($dbFileName)
      end
      @startDateTime = getTime()
      @days = @hours = @minutes = @seconds = 0
      @db.execute("INSERT INTO counter(start) VALUES(?);", @startDateTime)
      @updateInterval = interval
    else
      @db = SQLite3::Database.new($dbFileName)
    end
  end
  
  def returnAll()
    return @db.execute("SELECT * FROM counter ORDER BY start DESC;")
  end
  
  def getTime()
    return @db.get_first_row("select datetime('now','localtime');")[0]
  end
  
  
  def returnCountAsSeconds()
    return @days*24*60*60+@hours*60*60+@minutes*60+@seconds
  end
  
  def builderHelper(val)
    if val < 10
      return "0" << val.to_s
    else
      return val.to_s
    end
  end
  
  def countTotalTime()
    sum = 0
    returnAll().each do |entry|
      sum += entry[2].to_i
    end
    return sum
  end
  
  def returnCounterString()
    builder = ""
    builder << @days.to_s << " d  "
    builder << self.builderHelper(@hours) << " : "
    builder << self.builderHelper(@minutes) << " : "
    builder << self.builderHelper(@seconds)
    return builder
  end
  
  def returnCustomCounterString(count)
    m = count/60
    cSec = count - ((count/60)*60)
    h = m/60
    cMin = m - (h*60)
    d = h/24
    cHr = h - (d*24)
    
    builder = ""
    builder << d.to_s << " d  "
    builder << self.builderHelper(cHr) << " : "
    builder << self.builderHelper(cMin) << " : "
    builder << self.builderHelper(cSec)
    return builder
  end
  
  def countUp()
    if @seconds == 59
      @seconds = 0
      if @minutes == 59
        @minutes = 0
        if @hours == 23
          @hours = 0
          @days += 1
        else
          @hours += 1
        end
      else
        @minutes += 1
      end
    else
      @seconds += 1
    end
  end
  
  def save()
    @currentDateTime = getTime()
    @db.execute("UPDATE counter SET end=?, seconds=?, timestring=? WHERE start=?", @currentDateTime, self.returnCountAsSeconds(), self.returnCounterString(), @startDateTime)
  end
  
end


def webServerMethod()
  sleep(2) #ensure that the db file is created
  clock2 = Counter.new("fork")
  server = TCPServer.new('localhost', 9696)
  while (session = server.accept)
    response = ""
    response << "<html><body><center>"
    response << "Total runtime: " << clock2.returnCustomCounterString(clock2.countTotalTime()) << "<hr>"
    
    response << "<table border='1'>" << "<tr><td>Start</td><td>End</td><td>Seconds</td><td>Runtime</td></tr>"
    response << "\nDatabase content: \n"
    clock2.returnAll().each do |row|
      response << "<tr>" 
      row.each do |cell|
        response << "<td>" << cell.to_s << "</td>"
      end
      response << "</tr>"
    end
    
    response << "</table></center></body></html>" 
    headers = ["HTTP/1.1 200 OK",
              "Allow-Origin: *",
              "Server: "+RUBY_VERSION.to_s,
              "Content-Type: text/html; charset=utf-8",
              "Content-Length: #{response.bytesize}\r\n\r\n"].join("\r\n")
    session.print headers
    session.print response
    session.close()
  end
end

############

if RUBY_VERSION < "1.9"
  puts "Incompabitible Ruby version, must be >= 1.9"
  exit
end

Process.daemon($dirpath)

if (childpid=fork())
  clock = Counter.new($dbFileName)
  i = 0
  while true
    sleep(1)
    clock.countUp()
    i += 1
    if i == clock.updateInterval
      i = 0
      if !FileTest.exists?(File.join($dirpath,"shutdown"))
        clock.save()
      else
        File.delete(File.join($dirpath,"shutdown"))
        Process.kill("EXIT", childpid)
        exit
      end
    end
  end
else
  webServerMethod()
end