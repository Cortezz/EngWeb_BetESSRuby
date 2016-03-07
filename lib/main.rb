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
            when 2 then puts changeOdds(email)
            when 3 then puts subscribeToEvent(email)
            when 4 then puts listOfSubscribedEvents(email)
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
      @BetESS.fSubscribeBookieToEvent(ne.eventID,bookieEmail)
      @BetESS.fAddSubscribedEventTo(bookieEmail, ne.eventID)
      puts "Event was successfully added!"
   end

   ## Changes the odds of a certain event and notifies every bookie who subscribed to it.
   def changeOdds(bookieEmail)
      subscribedEvents = @BetESS.fGetSubscribedEventsFrom(bookieEmail)
      events = @BetESS.fMapOfAllEvents

      # List of all events
      puts "\t\tList of Events"
      subscribedEvents.each {|sEvent| puts "#{events[sEvent].toString}-------"}

      puts "Which event do you want to change the odds of: "
      eID = gets.chomp.to_i
      puts "-------"
      e = events[eID]
      puts "#{e.toString} \tNew Odds:"

      newOdds = []
      oldOdds = @BetESS.fDisplayOddsFrom(e.eventID)
      oldOdds.each do |s, odd|
         puts "#{s.desc}: "
         odd = gets.chomp.to_f
         newOdds.push(odd)
      end
      @BetESS.fChangeOddsTo(e.eventID, newOdds)
      puts "##############################"


   end

   ## Method which handles the subscription of an event by a bookie.
   ## In other words, it subscribes the bookie to a certain event and adds that same event into the bookie's subscribed events.
   def subscribeToEvent (bookieEmail)
      events = @BetESS.fMapOfAllEvents
      subscribedEvents = @BetESS.fGetSubscribedEventsFrom(bookieEmail)

      # Delete all the events he's already subscribed to
      subscribedEvents.each do |eventID|
         if (events.has_key?(eventID))
            events.delete(eventID)
         end
      end

      puts "\t\tList of Events"
      events.each {|eventID,event| puts "#{event.toString}-------"}

      if (events.length>0)
         puts "Which event do yo want to subscribe to: "
         id = gets.chomp.to_i

         @BetESS.fSubscribeBookieToEvent(id,bookieEmail)
         @BetESS.fAddSubscribedEventTo(bookieEmail,id)
         puts "Event subscription was successful!"
      else puts "There are no subscribable events."
      end


   end

   ## Prints the list of all subscribed events from a certain bookie.
   def listOfSubscribedEvents (bookieEmail)
      events = @BetESS.fMapOfAllEvents
      subscribedEvents = @BetESS.fGetSubscribedEventsFrom(bookieEmail)

      puts "\t\tSubscribed Events:"
      subscribedEvents.each {|eventID| puts "#{events[eventID].toString}------"}
      puts "########"
   end

   ##################### ADMIN APP ######################

   def adminApp
      loop do
         @adminMenu.executeMenu
         case @adminMenu.option
         when 1 then puts determineOutcome
         end

         break if (@adminMenu.option==0)
      end
   end

   ## Finishes an event (by registering its outcome), closes every bet associated with it
   def determineOutcome
      events = @BetESS.fMapOfAllEvents
      puts (@BetESS.fDisplayEvents)

      puts "Which event do you want to determine the outcome of: "
      id = gets.chomp.to_i
      e = events[id]
      puts e.toString

      puts "What is the outcome of that event: "
      outcome = gets.chomp.to_i

      @BetESS.fCloseEvent(e,outcome)
      puts "##############"

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
