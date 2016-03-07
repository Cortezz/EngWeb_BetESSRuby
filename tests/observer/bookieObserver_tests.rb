require_relative '../../lib/users/bookie'
require_relative '../../lib/events/normalEvent'
require 'test/unit'

class BookieObserver_Tests < Test::Unit::TestCase

   def setup
      @b = Users::Bookie.new("José Bookie", "admin@gmail.com","aa12345")
      @ne = Events::NormalEvent.new(1,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @ne.addObserver(@b)
      @b.subscribeTo(1)
   end

   ## Test to verify the amount of notifications from a bookie after the end of events he was following
   def test_observerNotifications1
      assert_equal(0,@b.amountOfNotifications)
   end

   def test_observerNotifications2
      @ne.closeEvent(1)
      assert_equal(1,@b.amountOfNotifications)
   end

   def test_observerNotifications3
      ne2 = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      ne2.addObserver(@b)
      @b.subscribeTo(2)
      @ne.closeEvent(0)
      ne2.closeEvent(2)
      assert_equal(2,@b.amountOfNotifications)
   end

   def test_observerNotifications4
      @ne.closeEvent(1)
      puts @b.notificationList
   end
   ##########################
end
