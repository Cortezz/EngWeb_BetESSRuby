
module Users
  #Class which represents the user
  class User
      def initialize(name, email, pwd)
        @name = name
        @email = email
        @password = pwd
        @notifications = []
      end

      def getEmail
        @email
      end

      def getName
        @name
      end

      def getPassword
        @password
      end

      def toString
        "Name: #{@name}\nE-mail: #{@email}\nPassword: #{@password}\n"
      end

      ################# NOTIFICATIONS ####################

      # Pushes a notification to the notification list
      def pushNotification(notification)
        @notifications.push(notification)
      end

      # Returns a string with all the notifications in it
      def notificationList
        s = "List of notifications:\n"
        @notifications.each {|x| s << x << "\n"}
        s
      end

      # Returns the amount of notifications
      def amountOfNotifications
        @notifications.length
      end

      # Empties the notification list
      def removeNotifications
        @notifications.clear
      end
      #######################################################
  end
end
