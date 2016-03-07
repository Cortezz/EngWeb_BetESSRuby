$LOAD_PATH << '.'
require_relative '../lib/facade'
require 'test/unit'

class Facade_Tests < Test::Unit::TestCase

   def setup
      @BetESS = Facade.new
      @name = "josé"
      @email = "j@gmail.com"
      @pwd = "12345"
      @ne = Events::NormalEvent.new(1,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @f = Sports::Football.new ("Football")
      @BetESS.fAddSport(@f.name, @f)
      @BetESS.fAddEvent(@f.name, @ne)
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
   ############ EVENTS ##############

   ## fAddEvent tests
   def test_fAddEvent1
      events = @BetESS.fMapOfAllEvents
      assert_equal(1, events.length)
   end

   def test_fAddEvent2
      ne2 = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @BetESS.fAddEvent(@f.name, ne2)
      events = @BetESS.fMapOfAllEvents
      assert_equal(2, events.length)
   end

   ## fGetAllEvents tests
   def test_fGetAllEvents1
      events = @BetESS.fGetAllEvents
      assert_equal(1, events.length)
   end

   def test_fGetAllEvents2
      events = @BetESS.fGetAllEvents
      football = events[@f.name]
      assert_equal(true, football.has_key?(1))
   end

   def test_fGetAllEvents3
      events = @BetESS.fGetAllEvents
      football = events[@f.name]
      assert_equal(false, football.has_key?(2))
   end

   ## fDisplayOddsFrom tests
   def test_fDisplayOddsFrom1
      odds = @BetESS.fDisplayOddsFrom(1)
      assert_equal(true, 1.5==odds[0].odd && 5==odds[1].odd && 2==odds[2].odd)
   end

   ## fMapOfAllEvents tests
   def test_fMapOfAllEvents1
      events = @BetESS.fMapOfAllEvents
      assert_equal(true, events.length==1 && events.has_key?(1))
   end

   def test_fMapOfAllEvents2
      ne2 = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @BetESS.fAddEvent(@f.name, ne2)
      events = @BetESS.fMapOfAllEvents
      assert_equal(true, events.length==2 && events.has_key?(1) && events.has_key?(2))
   end

   ## fChangeOddsTo tests
   def test_fChangeOddsTo1
      @BetESS.fChangeOddsTo(1,[10,9,8])
      odds = @BetESS.fDisplayOddsFrom(1)
      assert_equal(true, (10==odds[0].odd && 9==odds[1].odd && 8==odds[2].odd))
   end

   ## fGetEventCount tests
   def test_fGetEventCount1
      assert_equal(2, @BetESS.fGetEventCount)
   end

   ## fRemoveEvent tests
   def test_fRemoveEvent1
      @BetESS.fRemoveEvent(1)
      events = @BetESS.fMapOfAllEvents
      assert_equal(0, events.length)
   end

   def test_fRemoveEvent2
      ne2 = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @BetESS.fAddEvent(@f.name, ne2)
      @BetESS.fRemoveEvent(1)
      events = @BetESS.fMapOfAllEvents
      assert_equal(1, events.length)
   end


   ########## BETS #################

   ## fAddBet tests
   def test_fAddBet1
      events = @BetESS.fMapOfAllEvents
      e1 = events[1]
      @BetESS.fAddBet(e1, 5, "j@gmail.com",1, 5.22, 200)
      assert_equal(true,e1.bets.include?(5))
   end

   # fCloseEvent tests
   def test_fCloseEvent1
      @BetESS.fAddBet(@ne, 5, "j@gmail.com",1, 5.22, 200)
      @BetESS.fCloseEvent(@ne,2)
      assert_equal(1, @BetESS.fAmountOfNotificationsFrom("j@gmail.com"))
   end





end
