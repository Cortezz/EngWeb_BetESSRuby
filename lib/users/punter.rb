$LOAD_PATH << '.'
require_relative "user"


module Users
  class Punter < User

     attr_reader :betESSCoins

      def initialize(name, email, pwd)
        super(name,email,pwd)
        @betESSCoins = 0
      end
      
      ############## COINS ################

      ## Credits coins into the punter's account
      def creditCoins(amount)
        @betESSCoins += amount
      end

      ## Debits coins from the punter's account
      def debitCoins(amount)
        @betESSCoins -= amount
      end
      #####################################

      def toString
        super + "BetESSCoins: #{@betESSCoins}\n"
      end

  end
end
