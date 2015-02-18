require 'sqlite3'

$connection = nil
$db = nil
=begin
$db = SQLite3::Database.new("ksiazki.sqlite")
$db.execute("select * from ksiazki;") do |row|
  row.each do |y|
    print y.to_s+" "
  end
  puts "\n"
end
=end
def clearScreen
  system "clear" unless system "cls"
end

def init()
  dirpath = File.expand_path(File.dirname(__FILE__))
  if !FileTest.exists?(File.join(dirpath,"ksiazki.sqlite"))
    $db = SQLite3::Database.new("ksiazki.sqlite")
    $db.execute("CREATE TABLE ksiazki(imie TEXT, nazwisko TEXT, tytul TEXT)")
  else
    $db = SQLite3::Database.new("ksiazki.sqlite")
  end
end

def menu()
  while true
    clearScreen()
    puts "1. Dodaj wpis"
    puts "2. Poszukaj"
    puts "3. Usun pozycje"
    puts "4. Wyswietl wszystko"
    
    choice = gets.chomp.to_i
    
    case choice
    when 1
      add()
    when 2
      search()
    when 3
      remove()
    when 4
      all()
    else
      exit()
    end
  end
end

def add()
  clearScreen()
  print("IMIE: ")
  imie = gets.chomp.upcase
  print("NAZWISKO:")
  nazwisko = gets.chomp.upcase
  print("TYTUL:")
  tytul = gets.chomp.upcase
  $db.execute("INSERT INTO ksiazki(imie, nazwisko, tytul) VALUES(?,?,?);", imie, nazwisko, tytul)
  clearScreen()
  puts("OK!")
end

def search()
  clearScreen()
  puts "1. Imie"
  puts "2. Nazwisko"
  puts "3. Tytul"
  
  choice = gets.chomp.to_i
  
  case choice
  when 1
    print("IMIE:")
    imie = gets.chomp.upcase
    clearScreen()
    $db.execute("SELECT * FROM ksiazki WHERE imie=?;", imie).each do |row|
      puts row.to_s
    end
    gets.chomp
  when 2
    print("NAZWISKO:")
    nazwisko = gets.chomp.upcase
    clearScreen()
    $db.execute("SELECT * FROM ksiazki WHERE nazwisko=?;", nazwisko).each do |row|
      puts row.to_s
    end
    gets.chomp
  when 3
    print("TYTUL:")
    tytul = gets.chomp.upcase
    clearScreen()
    $db.execute("SELECT * FROM ksiazki WHERE tytul=?;", tytul).each do |row|
      puts row.to_s
    end
    gets.chomp
  else
    return
  end
end

def remove()
  clearScreen()
  puts "1. Imie"
  puts "2. Nazwisko"
  puts "3. Tytul"
  
  choice = gets.chomp.to_i
  
  case choice
  when 1
    print("IMIE:")
    imie = gets.chomp.upcase
    $db.execute("DELETE FROM ksiazki WHERE imie=?;", imie).each
    clearScreen()
  when 2
    print("NAZWISKO:")
    nazwisko = gets.chomp.upcase
    $db.execute("DELETE FROM ksiazki WHERE nazwisko=?;", nazwisko)
    clearScreen()
  when 3
    print("TYTUL:")
    tytul = gets.chomp.upcase
    $db.execute("DELETE FROM ksiazki WHERE tytul=?;", title)
    clearScreen()
  else
    return
  end
end

def all()
  clearScreen()
  i = 0
  $db.execute("SELECT * FROM ksiazki;").each do |row|
    puts row.to_s
    i+=1
  end
  puts "\nPOZYCJI: " + i.to_s
  gets.chomp
end

clearScreen()
init()
menu()