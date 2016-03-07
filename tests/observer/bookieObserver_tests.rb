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

   ############# END OF EVENT #############

   ## Tests to verify that end of event notifications are working
   def test_endOfEventNotifications1
      assert_equal(0,@b.amountOfNotifications)
   end

   def test_endOfEventNotifications2
      @ne.closeEvent(1)
      assert_equal(1,@b.amountOfNotifications)
   end

   def test_endOfEventNotifications3
      ne2 = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      ne2.addObserver(@b)
      @b.subscribeTo(2)
      @ne.closeEvent(0)
      ne2.closeEvent(2)
      assert_equal(2,@b.amountOfNotifications)
   end
   ############# ODD CHANGES #############

   ## Tests to verify that odd changes notifications are working
   def test_oddChangeNotifications1
      assert_equal(0,@b.amountOfNotifications)
   end

   def test_oddChangeNotifications2
      @ne.changeOdds([5,6,7])
      assert_equal(1,@b.amountOfNotifications)
   end

   def test_oddChangeNotifications3
      @ne.changeOdds([5,6,7])
      @ne.changeOdds([6,7,8])
      assert_equal(2,@b.amountOfNotifications)
   end

   def test_oddChangeNotifications4
      ne2 = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      ne2.addObserver(@b)
      @b.subscribeTo(2)
      @ne.changeOdds([4,5,6])
      ne2.changeOdds([6,7,8])
      assert_equal(2,@b.amountOfNotifications)
   end

end
