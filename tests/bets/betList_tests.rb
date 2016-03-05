require_relative '../../lib/bets/betList'
require 'test/unit'

class Bet_Tests < Test::Unit::TestCase

   def setup
      @bets = Bets::BetList.new
      @bets.addBet(1, "FC Porto x SC Braga", "filipe@gmail.com", 1, 2.33, 250)
   end

   ## getBet tests

   def test_getBet1
      b = @bets.getBet(1)
      assert_equal("filipe@gmail.com", b.punter)
   end

   def test_getBet2
      b = @bets.getBet(1)
      assert_kind_of(Bets::Bet, b)
   end

   ## addBet tests
   def test_addBet1
      @bets.addBet(2, "FC Porto x SL Benfica", "awwwh@gmail.com", 1, 1.5, 100)
      assert_equal(3, @bets.betCount)
   end

   def test_addBet2
      @bets.addBet(2, "FC Porto x SL Benfica", "awwwh@gmail.com", 1, 1.5, 100)
      assert_kind_of(Bets::Bet, @bets.getBet(2))
   end


end
