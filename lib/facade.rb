$LOAD_PATH << '.'

require_relative './users/userList'
require_relative './bets/betList'

class Facade

   def initialize
         @users = Users::UserList.new
         @bets = Bets::BetList.new
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

   ############# BETS #################

   ## TO-DO







end
