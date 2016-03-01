$LOAD_PATH << '.'
require "user"

class Punter < User

    def initialize(name, email, pwd)
      super(name,email,pwd)
      @betESSCoins = 0
    end

    ##Getters and Setters
    def getBetESSCoisn
      @betESSCoins
    end

    ############## COINS ################

    ## Credits coins into the punter's account
    def creditCoins(amount)
      @betESSCoins += amount
    end

    ## Debits coins from the punter's account
    def debitCoints(amount)
      @betESSCoins -= amount
    end
    #####################################

    def toString
      super + "BetESSCoins: #{@betESSCoins}\n"
    end

end
