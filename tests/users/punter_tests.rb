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
      assert_equal(@p.getName, @name)
   end

   def test_getEmail
      assert_equal(@p.getEmail, @email)
   end

   def test_getPassword1
      assert_equal(@p.getPassword, @password)
   end

   def test_getBetESSCoins1
      assert_equal(0, @p.getBetESSCoins)
   end
   ########## COINS ############

   ## creditCoins/debitCoins tests
   def test_creditCoins1
      @p.creditCoins(150)
      assert_equal(150, @p.getBetESSCoins)
   end

   def test_creditCoins2
      @p.creditCoins(150)
      @p.creditCoins(150)
      assert_equal(300, @p.getBetESSCoins)
   end

   def test_creditDebitCoins1
      @p.creditCoins(150)
      @p.debitCoins(50)
      assert_equal(100, @p.getBetESSCoins)
   end

   def test_creditDebitCoins2
      @p.creditCoins(150)
      @p.debitCoins(150)
      assert_equal(0, @p.getBetESSCoins)
   end
   #############################
end
