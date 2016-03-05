$LOAD_PATH << '.'
require_relative '../lib/facade'
require 'test/unit'

class Facade_Tests < Test::Unit::TestCase

   def setup
      @BetESS = Facade.new
      @name = "josé"
      @email = "jo@gmail.com"
      @pwd = "12345"
      @BetESS.fAddPunter(@name, @email, @pwd)
   end

   ######## USERS ###########

   ## fValidateEmail tests
   def tests_fValidateEmail1
      assert_equal(false, @BetESS.fValidateEmail(@email))
   end

   def tests_fValidateEmail2
      assert_equal(true, @BetESS.fValidateEmail("aaaa"))
   end

   ## fCheckCredentials tests
   def test_fCheckCredentials1
      assert_equal(true, @BetESS.fCheckCredentials(@email,"12345"))
   end

   def test_fCheckCredentials2
      assert_equal(false, @BetESS.fCheckCredentials(@email, "asdfasdf"))
   end

   def test_fCheckCredentials3
      assert_equal(false, @BetESS.fCheckCredentials(@email, "1234 5"))
   end


   ###### NOTIFICATIONS #########

   ## fAmountOfNotificationsFrom tests
   def test_fAmountOfNotificationsFrom1
      assert_equal(@BetESS.fAmountOfNotificationsFrom(@email),0)
   end

   ## fNotificationListFrom tests
   def test_fNotificationListFrom1
      s = "List of notifications:\n"
      assert_equal(@BetESS.fNotificationListFrom(@email),s)
   end

   ## fRemoveNotificationsFrom tests
   def test_fRemoveNotificationsFrom1
      @BetESS.fRemoveNotificationsFrom(@email)
      assert_equal(@BetESS.fAmountOfNotificationsFrom(@email),0)
   end

   ############# PUNTERS #############

   ## fCreditCoinsTo/fDebitCoinsFrom/fGetBetESSCoinsFrom tests
   def test_fCreditCoinsTo1
      @BetESS.fCreditCoinsTo(@email, 150)
      assert_equal(150, @BetESS.fGetBetESSCoinsFrom(@email))
   end

   def test_fDebitCoinsFrom1
      @BetESS.fCreditCoinsTo(@email, 150)
      @BetESS.fDebitCoinsFrom(@email, 50)
      assert_equal(100, @BetESS.fGetBetESSCoinsFrom(@email))
   end

   def test_fDebitCoinsFrom2
      @BetESS.fCreditCoinsTo(@email, 150)
      @BetESS.fDebitCoinsFrom(@email, 150)
      assert_equal(0, @BetESS.fGetBetESSCoinsFrom(@email))
   end

   def test_fGetBetESSCoinsFrom1
      assert_equal(@BetESS.fGetBetESSCoinsFrom(@email),0)
   end


   ########### BOOKIES ################

   ## fAddSubscribedEventTo/fGetSubscribedEventsFrom tests
   def test_fGetSubscribedEventsFrom1
      @BetESS.fAddBookie("name","email","pwd")
      assert_equal(0,@BetESS.fGetSubscribedEventsFrom("email").size())
   end


   def test_addSubscribedEventTo1
      @BetESS.fAddBookie("name","email","pwd")
      @BetESS.fAddSubscribedEventTo("email",2)
      events = @BetESS.fGetSubscribedEventsFrom("email")
      assert_equal(true, events.include?(2))
   end

end
