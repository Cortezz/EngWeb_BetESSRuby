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
   def fAddSubscribedEventTo(eventID, email)
      @users.addSubscribedEventTo(eventID, email)
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

   ## fSubscribeBookieToEvent!

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
   def fRemoveEvent (e)
      @sports.removeEvent(e)
   end
   ############# BETS #################


   ##### NEEDS EVENT AS PARAM AS WELL!
   #Adds a bet:
   #  1 - Into the punter's open bet list.
   #  2 - Into the event's bet list.
   def fAddBet (event, betID, punter, option, odds, coins)
      @bets.addBet(betID, event.description ,punter,option,odds,coins)
      event.addBet(betID)
   end



   ## Returns the amount of bets stored in the system.
   def fGetBetCounter
      @bets.betCount
   end

   ## TO-DO







end
