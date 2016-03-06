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
## events
require_relative './events/event'
require_relative './events/normalEvent'
## sports
require_relative  './sports/sportsList'
require_relative './sports/sport'
require_relative './sports/football'
## UI
require_relative 'UI/menu'
## Facade
require_relative 'facade'

class Main

   def initialize
      puts "##############################\n\n    Welcome to BetESS v4.0! \n"
      @BetESS = Facade.new
      loadSports
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

   ##################### PUNTER APP #########################


   def punterApp(email)
      loop do

         if (@BetESS.fAmountOfNotificationsFrom(email)>0)
            puts ("You have new notifications!\n\n")
            puts (@BetESS.fNotificationListFrom(email))
            @BetESS.fRemoveNotificationsFrom(email)
         end

         @punterMenu.executeMenu
         case @punterMenu.option
            when 1 then puts listOfEvents
            when 2 then puts historyOfBets(email)
            when 3 then puts placeBet(email)
            when 4 then puts availableCoins(email)
            when 5 then puts insertCoins(email)
         end
         break if (@punterMenu.option==0)
      end
   end

   ## Prints the list of all events.
   def listOfEvents
      puts (@BetESS.fDisplayEvents)
   end

   ## Prints the user's bet history
   def historyOfBets(email)
      puts (@BetESS.fBetHistoryFrom(email))
   end

   ## This method will allows the punter to take bets.
   def placeBet (email)
      events = @BetESS.fMapOfAllEvents
      puts (@BetESS.fDisplayEvents)

      puts "#############################\nWhich event do you want to bet on: "
      id = gets.chomp.to_i
      event = events[id]

      puts "------------\n#{event.toString}------------\n"
      puts "What do you want to bet on (NOTE: Draw is represented by 0):"
      option = gets.chomp.to_i
      puts "Amount of coins: "
      coins = gets.chomp.to_f

      odd = event.getSpecificOdd(option)
      @BetESS.fAddOpenBetTo(@BetESS.fGetBetCount, email)
      @BetESS.fAddBet(event, @BetESS.fGetBetCount, email, option, odd, coins)
      @BetESS.fDebitCoinsFrom(email,coins)
      puts "The bet was successfully created!"
   end



   # Shows how many coins a user has.
   def availableCoins (email)
      puts "The amount of coins in your account is: #{@BetESS.fGetBetESSCoinsFrom(email)}"
   end

   # Inserts a specified amount of coins in the user's account.
   def insertCoins (email)
      puts "How many coins do you wish to credit: "
      coins = gets.chomp.to_f
      @BetESS.fCreditCoinsTo(email,coins)
      puts "The amount of coins in your account is: #{@BetESS.fGetBetESSCoinsFrom(email)}"
   end

   ##################### BOOKIE APP ######################

   def bookieApp(email)
      loop do

         if (@BetESS.fAmountOfNotificationsFrom(email)>0)
            puts ("You have new notifications!\n\n")
            puts (@BetESS.fNotificationListFrom(email))
            @BetESS.fRemoveNotificationsFrom(email)
         end

         @bookieMenu.executeMenu
         case @bookieMenu.option
            when 1 then puts showSportsMenu(email)
            when 2 then puts "changeOdds()"
            when 3 then puts "subscribeToEvent()"
            when 4 then puts "ListOfSubscribedEvents()"
         end
         break if (@bookieMenu.option==0)
      end
   end

   ## Method which will display every available sport. The admin will only be able to place events related to these sports.
   def showSportsMenu (email)
      loop do
         @sportsMenu.executeMenu
         case @sportsMenu.option
            when 1 then insertNormalEvent("Football",email)
         end
         break if (@sportsMenu.option==0)
      end
   end

   ## Inserts a normal event (possible outcomes are victory, draw and loss).
   def insertNormalEvent(sportname, bookieEmail)
      puts "Description:"
      description = gets.chomp
      puts "Odds:\n1:"
      odd1 = gets.chomp.to_f
      puts "X: "
      drawOdd = gets.chomp.to_f
      puts "2: "
      odd2 = gets.chomp.to_f

      ne = Events::NormalEvent.new(@BetESS.fGetEventCount, description,bookieEmail,odd1,odd2,drawOdd)
      @BetESS.fAddEvent(sportname,ne)
      #@BetESS.fSubscribeBookieToEvent(ne.eventID,bookieEmail)
      @BetESS.fAddSubscribedEventTo(bookieEmail, ne.eventID)
      puts "Event was successfully added!"
   end


   ##################### ADMIN APP ######################

   def adminApp
      loop do
         @adminMenu.executeMenu
         case @adminMenu.option
         when 1 then puts "determineOutcome()"
         end

         break if (@adminMenu.option==0)
      end
   end

   ######################################################



   def loadSports
      f = Sports::Football.new("Football")
      @BetESS.fAddSport(f.name,f)
   end

   def loadMenus
      loginM = ["Register", "Login", "Admin Register", "Admin Login", "Bookie Register","Bookie Login"]
      punterM = ["List of events", "History of bets", "Place a bet", "Available coins", "Insert coins"]
      adminM = ["Determine outcome of event"]
      bookieM = ["Insert Event", "Change Odds of an Event", "Subscribe to an event", "List of subscribed events"]
      sports = ["Football"]


      @sportsMenu = UI::Menu.new(sports)
      @loginMenu = UI::Menu.new(loginM)
      @punterMenu = UI::Menu.new(punterM)
      @adminMenu = UI::Menu.new(adminM)
      @bookieMenu = UI::Menu.new(bookieM)
   end



end

m = Main.new()
m.mainApp
