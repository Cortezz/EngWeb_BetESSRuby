require_relative '../../lib/sports/football'
require_relative '../../lib/events/normalEvent'
require 'test/unit'

class Football_Tests < Test::Unit::TestCase

   def setup
      @football = Sports::Football.new("Football")
      @ne = Events::NormalEvent.new(1,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @football.addEvent(@ne)
   end

   ## containsEvent test
   def test_containsEvent1
      assert_equal(true,@football.containsEvent(1))
   end

   def test_containsEvent2
      assert_equal(false,@football.containsEvent(5))
   end

   ##displayOddsFrom tests
   def test_displayOddsFrom1
         results = @football.displayOddsFrom(1)
         assert_equal(3, results.size)
   end

   def test_displayOdds2
      results = @football.displayOddsFrom(1)
      assert_equal(true, (1.5==results[0].odd && 5==results[1].odd && 2 == results[2].odd))
   end

   ##changeOddsTo tests
   def test_changeOddsTo1
      @football.changeOddsTo(1,[3,2,1])
      results = @football.displayOddsFrom(1)
      assert_equal(true, (3==results[0].odd && 2==results[1].odd && 1 == results[2].odd))
   end

   ## removeEvent tests
   def test_removeEvent1
      @football.removeEvent(1)
      assert_equal(false, @football.containsEvent(1))
   end

   ## addEvent tests
   def test_addEvent1
      ne = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @football.addEvent(ne)
      assert_equal(true, @football.containsEvent(2))
   end
   


end
