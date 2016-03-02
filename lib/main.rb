$LOAD_PATH << '.'

## Users
require_relative './users/bookie'
require_relative './users/admin'
require_relative './users/user'
require_relative './users/punter'
## UI
require_relative 'UI/menu'

class Main
   @menuLogin

   def initialize
      puts "##############################\n\n    Welcome to BetESS v4.0! \n"
      loadMenus
   end

   def loadMenus
      login = ["Register", "Login", "Admin Register", "Admin Login", "Bookie Register","Bookie Login"]
      @menuLogin = UI::Menu.new(login)
   end

   def mainApp
      loop do
         @menuLogin.executeMenu
         case @menuLogin.getOption
            when 1 then register
            when 2 then puts 'LOGIN: Not yet implemented'
            when 3 then puts 'ADMIN REGISTER: Not yet implemented'
            when 4 then puts 'ADMIN LOGIN: Not yet implemented'
            when 5 then puts 'BOOKIE REGISTER: Not yet implemented'
            when 6 then puts 'BOOKIE LOGIN: Not yet implemented'
            else  puts 'Unkown option!'
         end
      break if @menuLogin.getOption==0
      end
   end

   def register
      puts "Name: "
      name = gets.chomp
      puts "E-mail: "
      email = gets.chomp
      puts "Password: "
      pwd = gets.chomp

      u = Users::Punter.new(name,email,pwd)
      puts u.toString
   end

end

m = Main.new()
m.mainApp
