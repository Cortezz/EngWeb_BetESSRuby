require_relative 'bet'

module Bets

   class BetList

      attr_reader :betCount

      def initialize
         @bets = Hash.new
         @betCount = 0
      end

      ############# BETS ###############

      ## Returns a bet, given its ID.
      def getBet (betID)
         @bets[betID]
      end

      ## Adds a bet into the list.
      def addBet(betID, description, punter, option, odds, coins)
         b = Bets::Bet.new(betID,description, punter,option,odds,coins)
         @bets[betID] = b
         @betCount += 1
      end

      #################################


   end

end
