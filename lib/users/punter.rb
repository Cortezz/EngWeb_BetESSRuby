$LOAD_PATH << '.'
require_relative "user"


module Users
  class Punter < User

     attr_reader :betESSCoins
     attr_reader :openBets
     attr_reader :closedBets

      def initialize(name, email, pwd)
        super(name,email,pwd)
        @betESSCoins = 0
        @openBets = Set.new([])
        @closedBets = Set.new([])
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
      ############## BETS #################

      ## Adds a bet to the punter's open bet list.
      def addOpenBet (betID)
         @openBets.add(betID)
      end

      ## Removes a bet from the punter's open bet list and inserts the same bet into the closed bet list.
      def closeOpenBet (betID)
         if (@openBets.delete?(betID))
            @closedBets.add(betID)
         end
      end
      #####################################

      def toString
        super + "BetESSCoins: #{@betESSCoins}\n"
      end

  end
end
