require_relative '../../lib/users/bookie'
require 'test/unit'

class Bookie_Tests < Test::Unit::TestCase

   def setup
      @name = "João Bookie"
      @email = "jBookie@gmail.com"
      @password = "bb12345"
      @b = Users::Bookie.new(@name, @email,@password)
   end

   ## Getters
   def test_getName1
      assert_equal(@b.getName, @name)
   end

   def test_getEmail1
      assert_equal(@b.getEmail, @email)
   end

   def test_getPassword1
      assert_equal(@b.getPassword, @password)
   end

   def test_getSubscribedEvents1
      assert_equal(0, @b.getSubscribedEvents.size())
   end

   def test_getSubscribedEvents2
      @b.subscribeTo(1)
      @b.subscribeTo(2)
      events = @b.getSubscribedEvents
      assert_equal(2, events.size())
   end


   ########## EVENTS ########

   ## subscribeTo/amountOfSubscribedEvents tests
   def test_subscribeTo1
      assert_equal(@b.amountOfSubscribedEvents,0)
   end

   def test_subscribeTo2
      @b.subscribeTo(1)
      assert_equal(@b.amountOfSubscribedEvents,1)
   end

   def test_subscribeTo3
      @b.subscribeTo(1)
      @b.subscribeTo(2)
      @b.subscribeTo(3)
      @b.subscribeTo(4)
      assert_equal(@b.amountOfSubscribedEvents,4)
   end

   ## unsubscribeTo/amountOfSubscribedEvents tests
   def test_unsubscribeTo1
      @b.unsubscribeTo(1)
      assert_equal(@b.amountOfSubscribedEvents,0)
   end

   def test_unsubscribeTo2
      @b.subscribeTo(1)
      @b.unsubscribeTo(1)
      assert_equal(@b.amountOfSubscribedEvents,0)
   end

   def test_unsubscribeTo3
      @b.subscribeTo(1)
      @b.subscribeTo(2)
      @b.unsubscribeTo(2)
      assert_equal(@b.amountOfSubscribedEvents,1)
   end
   ##########################

end
