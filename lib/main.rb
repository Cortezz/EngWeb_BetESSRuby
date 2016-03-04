$LOAD_PATH << '.'

## Users
require_relative './users/bookie'
require_relative './users/admin'
require_relative './users/user'
require_relative './users/punter'
require_relative './users/userList'
## Bets
require_relative './bets/bet'
require_relative './bets/betList'
## UI
require_relative 'UI/menu'
## Facade
require_relative 'facade'

class Main

   def initialize
      puts "##############################\n\n    Welcome to BetESS v4.0! \n"
      @BetESS = Facade.new
      loadMenus
   end

   def mainApp
      loop do
         @loginMenu.executeMenu
         case @loginMenu.option
            when 1 then register("punter")
            when 2 then login("punter")
            when 3 then register("admin")
            when 4 then login("admin")
            when 5 then register("bookie")
            when 6 then login ("bookie")
            else  puts 'Unkown option!'
         end
      break if @loginMenu.option==0
      end
   end


   ## Method which deals with user registration.
   def register (userType)
      puts "Name: "
      name = gets.chomp
      puts "E-mail: "
      email = gets.chomp
      puts "Password: "
      pwd = gets.chomp

      if (@BetESS.fValidateEmail(email))
         case userType
            when "punter" then @BetESS.fAddPunter(name,email,pwd)
            when "bookie" then @BetESS.fAddBookie(name,email,pwd)
            when "admin" then @BetESS.fAddAdmin(name,email,pwd)
         end
         puts "Your registration was successful!"
      else puts "That e-mail already exists!"
      end
   end

   ## Method which deals with user login
   def login (userType)

      puts "E-mail: "
      email = gets.chomp
      puts "Password: "
      pwd = gets.chomp

      if (!@BetESS.fValidateEmail(email))
         if (@BetESS.fCheckCredentials(email,pwd))
            case userType
               when "punter" then
                  puts "Your login was successful!"
                  punterApp(email)
               when "bookie" then
                  puts "Your login was successful!"
                  bookieApp(email)
               when "admin" then
                  puts "Your login was successful!"
                  adminApp
            end

         else puts "Either the e-mail or the password are wrong."
         end
      else puts "That e-mail does not exist."
      end
   end


   def punterApp(email)
      loop do

         if (@BetESS.fAmountOfNotificationsFrom(email)>0)
            puts ("You have new notifications!\n\n")
            puts (@BetESS.fNotificationListFrom(email))
            @BetESS.fRemoveNotificationsFrom(email)
         end

         @punterMenu.executeMenu
         case @punterMenu.option
            when 1 then puts "ListOfEvents()"
            when 2 then puts "HistoryOfBets()"
            when 3 then puts "PlaceBet()"
            when 4 then puts "AvailableCoins()"
            when 5 then puts "InsertCoins()"
         end
         break if (@punterMenu.option==0)
      end
   end


   def bookieApp(email)
      loop do

         if (@BetESS.fAmountOfNotificationsFrom(email)>0)
            puts ("You have new notifications!\n\n")
            puts (@BetESS.fNotificationListFrom(email))
            @BetESS.fRemoveNotificationsFrom(email)
         end

         @bookieMenu.executeMenu
         case @bookieMenu.option
            when 1 then puts "showSportsMenu()"
            when 2 then puts "changeOdds()"
            when 3 then puts "subscribeToEvent()"
            when 4 then puts "ListOfSubscribedEvents()"
         end
         break if (@bookieMenu.option==0)
      end
   end

   def adminApp
      loop do
         @adminMenu.executeMenu
         case @adminMenu.option
         when 1 then puts "determineOutcome()"
         end

         break if (@adminMenu.option==0)
      end
   end




   def loadMenus
      loginM = ["Register", "Login", "Admin Register", "Admin Login", "Bookie Register","Bookie Login"]
      punterM = ["List of events", "History of bets", "Place a bet", "Coins available", "Insert coins"]
      adminM = ["Determine outcome of event"]
      bookieM = ["Insert Event", "Change Odds of an Event", "Subscribe to an event", "List of subscribed events"]

      @loginMenu = UI::Menu.new(loginM)
      @punterMenu = UI::Menu.new(punterM)
      @adminMenu = UI::Menu.new(adminM)
      @bookieMenu = UI::Menu.new(bookieM)
   end



end

m = Main.new()
m.mainApp
