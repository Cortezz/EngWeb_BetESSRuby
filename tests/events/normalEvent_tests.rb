require_relative '../../lib/events/normalEvent'
require 'test/unit'

class NormalEvent_Tests < Test::Unit::TestCase

   def setup
      @ne = Events::NormalEvent.new(1,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
   end


   ######### EVENT ##########

   ## closeEvent tests
   def test_closeEvent1
      assert_equal(-1,@ne.outcome)
   end

   def test_closeEvent2
      @ne.closeEvent(1)
      assert_equal(1, @ne.outcome)
   end

   ## addBet tests
   def test_addBet1
      @ne.addBet(2)
      assert_equal(true, @ne.bets.include?(2))
   end

   def test_addBet2
      @ne.addBet(3)
      @ne.addBet(4)
      @ne.addBet(5)
      assert_equal(3, @ne.bets.size())
   end

   ########## NORMAL EVENT ###########

   ## displayOdds tests
   def test_displayOdds1
      results = @ne.displayOdds
      assert_equal(3, results.size)
   end

   def test_displayOdds2
      results = @ne.displayOdds
      assert_equal(true, (1.5==results[0].odd && 5==results[1].odd && 2 == results[2].odd))
   end

   ## getSpecificOdd tests
   def test_getSpecificOdd1
      assert_equal(1.5, @ne.getSpecificOdd(1))
   end

   def test_getSpecificOdd2
      assert_equal(5, @ne.getSpecificOdd(0))
   end

   def test_getSpecificOdd3
      assert_equal(2, @ne.getSpecificOdd(2))
   end

   def test_getSpecificOdd4
      assert_equal(-1, @ne.getSpecificOdd(5))
   end

   ## changeOdsd test
   def test_changeOdds1
      @ne.changeOdds([10,11,12])
      assert_equal(10, @ne.getSpecificOdd(1))
   end

   def test_changeOdds2
      @ne.changeOdds([10,11,12])
      assert_equal(11, @ne.getSpecificOdd(0))
   end

   def test_changeOdds3
      @ne.changeOdds([10,11,12])
      assert_equal(12, @ne.getSpecificOdd(2))
   end









end
