require_relative '../../lib/bets/bet'
require_relative '../../lib/users/punter'
require 'test/unit'

class BetList_Test < Test::Unit::TestCase

   def setup
      @p = Users::Punter.new("filipe", "filipe@gmail.com", "13245")
      @b = Bets::Bet.new(1, "FC Porto x SC Braga", @p, 1, 2.33, 250)
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
