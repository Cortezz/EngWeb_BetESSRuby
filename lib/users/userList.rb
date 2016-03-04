$LOAD_PATH << '.'
require_relative 'user'
require_relative 'punter'
require_relative 'admin'
require_relative 'bookie'

module Users
   class UserList
      def initialize
         @users = Hash.new
      end


      ################ USERS ##################

      # Returns a user, given its email
      def getUser (email)
         @users[email]
      end

      #Checks whether an e-mail is already in the system
      def validateEmail(email)
         @users.has_key?(email)
      end

      #Check if some user's credentials are correct
      def checkCredentials (email, pwd)
            u = @users[email]
            (email == u.getEmail && pwd == u.getPassword)
      end

      # Pushes a notification to a certain user
      def pushNotificationTo (email, notification)
         @users[email].pushNotification(notification)
      end

      # Returns the amount of notifications form a certain user
      def amountOfNotificationsFrom (email)
         @users[email].amountOfNotifications
      end

      # Gets the notifications from a certain user
      def notificationListFrom (email)
         @users[email].notificationList
      end

      # Removes all notifications from a certain user
      def removeNotificationsFrom (email)
         @users[email].removeNotifications
      end

      ############### PUNTER #####################

      #Adds a Punter to the user list
      def addPunter (name, email,pwd)
         u = Users::Punter.new(name,email,pwd)
         @users[email] = u
      end

      # Gets the amount of coins from a certain user
      def getBetESSCoinsFrom (email)
         @users[email].getBetESSCoins
      end

      #Credits coins to a certain user
      def creditCoinsTo (email, amount)
         @users[email].creditCoins(amount)
      end

      #Debits coins from a certain user
      def debitCoinsFrom (email, amount)
         @users[email].debitCoins(amount)
      end

      ############################################


      ################ BOOOKIE ###################

      # Adds a bookie to the user list
      def addBookie(name, email, pwd)
         b = Users::Bookie.new(name,email,pwd)
         @users[email] = b
      end

      # Adds an event to a certain bookie's subscribed list
      def addSubscribedEventTo(email, eventID)
         @users[email].subscribeTo(eventID)
      end

      # Gets all the subscribed events from a certain bookie
      def getSubscribedEventsFrom (email)
         @users[email].getSubscribedEvents
      end

      ############################################

      ################# ADMIN ####################

      # Adds an admin into the users list
      def addAdmin (name, email, pwd)
         a = Users::Admin.new(name,email,pwd)
         @users[email] = a
      end

      ############################################

      def toString
         s = "User List:\n"
         @users.each do |name, user|
            s << user.toString
         end
         s
      end
   end

end
