require_relative '../../lib/users/punter'
require 'test/unit'

class Punter_Tests < Test::Unit::TestCase

   def setup
      @name = "Filipe Apostador"
      @email = "fa@gmail.com"
      @password = "12345"
      @p = Users::Punter.new(@name, @email,@password)
   end

   ## Getters
   def test_getName
      assert_equal(@p.name, @name)
   end

   def test_getEmail
      assert_equal(@p.email, @email)
   end

   def test_getPassword1
      assert_equal(@p.password, @password)
   end

   def test_getBetESSCoins1
      assert_equal(0, @p.betESSCoins)
   end
   ########## COINS ############

   ## creditCoins/debitCoins tests
   def test_creditCoins1
      @p.creditCoins(150)
      assert_equal(150, @p.betESSCoins)
   end

   def test_creditCoins2
      @p.creditCoins(150)
      @p.creditCoins(150)
      assert_equal(300, @p.betESSCoins)
   end

   def test_creditDebitCoins1
      @p.creditCoins(150)
      @p.debitCoins(50)
      assert_equal(100, @p.betESSCoins)
   end

   def test_creditDebitCoins2
      @p.creditCoins(150)
      @p.debitCoins(150)
      assert_equal(0, @p.betESSCoins)
   end
   ############## BETS ##############

   ## addOpenBet tests
   def test_addOpenBet1
      assert_equal(0, @p.openBets.size())
   end

   def test_addOpenBet2
      @p.addOpenBet(1)
      assert_equal(1, @p.openBets.size())
   end

   def test_addOpenBet3
      @p.addOpenBet(1)
      @p.addOpenBet(2)
      @p.addOpenBet(1)
      @p.addOpenBet(3)
      assert_equal(3, @p.openBets.size())
   end

   ## closeOpenBet tests
   def test_closeOpenBet1
      assert_equal(0, @p.closedBets.size())
   end

   def test_closeOpenBet2
      @p.addOpenBet(1)
      @p.closeOpenBet(1)
      assert_equal(true, (@p.closedBets.size()==1 && @p.openBets.size()==0))
   end

   def test_closeOpenBet3
      @p.addOpenBet(2)
      @p.addOpenBet(4)
      @p.addOpenBet(5)
      @p.closeOpenBet(5)
      @p.closeOpenBet(4)
      @p.closeOpenBet(100)
      assert_equal(true, (@p.closedBets.size()==2 && @p.openBets.size()==1))
   end



   ##
end
