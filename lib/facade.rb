$LOAD_PATH << '.'

require_relative './users/userList'
require_relative './bets/betList'
require_relative './sports/sportsList'

class Facade

   def initialize
         @users = Users::UserList.new
         @bets = Bets::BetList.new
         @sports = Sports::SportsList.new
   end


   ############## USERS ###############
   ## Checks whether a certain e-mail is already in the system or not.
   def fValidateEmail (email)
      @users.validateEmail(email)
   end

   ## Returns the amount of notifications of a certain user, given his e-mail.
   def fCheckCredentials (email, pwd)
      @users.checkCredentials(email,pwd)
   end

   ########## NOTIFICATIONS ###########

   ## Returns the amount of notifications from a certain user, given his e-mail.
   def fAmountOfNotificationsFrom (email)
      @users.amountOfNotificationsFrom(email)
   end

   ## Gets all the notifications from a certain user, specified by his e-mail.
   def fNotificationListFrom (email)
      @users.notificationListFrom(email)
   end

   ## Removes the notifications from a certain user, specified by his e-mail.
   def fRemoveNotificationsFrom (email)
      @users.removeNotificationsFrom(email)
   end

   ########### PUNTERS ################

   ## Adds a punter to the system.
   def fAddPunter (name, email, pwd)
      @users.addPunter(name,email,pwd)
   end

   ## Returns how many coins a punter has, given his e-mail.
   def fGetBetESSCoinsFrom (email)
      @users.getBetESSCoinsFrom(email)
   end

   ## Debits coins from a certian punter, given his e-mail.
   def fDebitCoinsFrom (email, amount)
      @users.debitCoinsFrom(email, amount)
   end

   ## Credits coins from a certain punter, given his e-mail.
   def fCreditCoinsTo (email, amount)
      @users.creditCoinsTo(email,amount)
   end

   ##Returns the bet history in string representation from a punter, given his e-mail.
   def fBetHistoryFrom (email)
      openBets = @users.getOpenBetsFrom(email)
      closedBets = @users.getClosedBetsFrom(email)
      s = "\t\tOpen Bets \n"
      openBets.each {|betID| s << @bets.getBet(betID).toString << "\n----\n"}
      s << "\t\tClosed Bets\n"
      closedBets.each {|betID| s << @bets.getBet(betID).toString << "\n----\n"}
      s
   end

   ## Adds a bet to a certain punter, given his e-mail.
   def fAddOpenBetTo (betID, email)
      @users.addOpenBetTo(betID,email)
   end


   ########### BOOKIES ################

   ## Adds a bookie to the system.
   def fAddBookie(name, email, pwd)
      @users.addBookie(name, email, pwd)
   end

   ## Adds a subscrived event to a bookie.
   def fAddSubscribedEventTo(email, eventID)
      @users.addSubscribedEventTo(email, eventID)
   end

   ## Returns all subscribed event IDs from a certain bookie, given his e-mail.
   def fGetSubscribedEventsFrom(email)
      @users.getSubscribedEventsFrom(email)
   end



   ############# ADMIN ################

   ## Adds an admin into the user's list.
   def fAddAdmin (name, email, pwd)
      @users.addAdmin(name,email,pwd)
   end

   ############# SPORTS ###############

   ## Adds a sport into the system.
   def fAddSport (name, sport)
      @sports.addSport(name,sport)
   end

   ############# EVENTS ###############

   ## Adds an event to the system.
   def fAddEvent(name,event)
      @sports.addEvent(name,event)
   end

   ## Adds a bookie subscription to a certain event
   def fSubscribeBookieToEvent(eventID, bookieEmail)
      b = @users.getUser(bookieEmail)
      @sports.subscribeBookieToEvent(eventID,b)
   end

   ## The events are mapped according to the sport they represent. This method returns a single collection with all events in it.
   def fGetAllEvents
      @sports.getAllEvents
   end

   ## Returns all events in string representation
   def fDisplayEvents
      @sports.displayEvents
   end

   ## Changes the odds of an event.
   def fDisplayOddsFrom (eventID)
      @sports.slDisplayOddsFrom(eventID)
   end

   ## Changes the odds of an event.
   def fChangeOddsTo (eventID, newOdds)
      @sports.slChangeOddsTo(eventID,newOdds)
   end

   ## Returns a map with every existing event, mapped according to its ID.
   def fMapOfAllEvents
      @sports.mapOfAllEvents
   end

   ## Returns the amount of events stored in the system.
   def fGetEventCount
      @sports.eventCount
   end

   ## Auxiliar method called by @CloseBet in order to remove an event from the system.
   def fRemoveEvent (eventID)
      @sports.removeEvent(eventID)
   end
   ############# BETS #################


   ##### NEEDS EVENT AS PARAM AS WELL!
   #Adds a bet:
   #  1 - Into the punter's open bet list.
   #  2 - Into the event's bet list.
   def fAddBet (event, betID, punterEmail, option, odds, coins)
      punter = @users.getUser(punterEmail)
      @bets.addBet(betID, event.description,punter,option,odds,coins)
      event.addBet(betID)
   end

   ## Returns the amount of bets stored in the system.
   def fGetBetCount
      @bets.betCount
   end

   ## Closes the bets of a specified event, and credit/debits into their account based on the outcome.
   def fCloseEvent (event, outcome)
      gains = losses = 0
      punterBets = event.bets

      punterBets.each do |betID|
         b = @bets.getBet(betID)
         if (b.option == outcome)
            b.closeBet(true)
            value = b.coins * b.odd
            @users.creditCoinsTo(b.punter.email, value)
            gains += value
         else
            b.closeBet(false)
            losses += b.coins
         end
         @users.closeOpenBetTo(betID,b.punter.email,)
      end

      event.gains = gains
      event.losses = losses
      event.closeEvent(outcome)
      fRemoveEvent(event.eventID)
   end


end
