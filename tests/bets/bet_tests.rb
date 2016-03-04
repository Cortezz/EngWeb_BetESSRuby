require_relative '../../lib/bets/bet'
require 'test/unit'

class BetList_Test < Test::Unit::TestCase

   def setup
      @b = Bets::Bet.new(1, "FC Porto x SC Braga", "filipe@gmail.com", 1, 2.33, 250)
   end

   ## closeBet tests
   def test_closeBet1
      @b.closeBet(true)
      assert_equal(@b.closed, true)
   end

   def test_closeBet2
      @b.closeBet(true)
      assert_equal(@b.won, true)
   end

   def test_closeBet3
      @b.closeBet(false)
      assert_equal(@b.won, false)
   end

end
