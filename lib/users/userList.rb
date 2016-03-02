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

      #Checks whether an e-mail is already in the system
      def validateEmail(email)
         @users.has_key?(email)
      end

      #Check if some user's credentials are correct
      def checkCredentials (email, pwd)
            @users[email] == pwd
      end

      def pushNotifcationTo (email, notification)
         @users[email].pushNotification(notification)
      end

      ############### PUNTER #####################

      #Adds a Punter to the user list
      def addPunter (name, email,pwd)
         u = Users::Punter.new(name,email,pwd)
         @users[name] = u
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
