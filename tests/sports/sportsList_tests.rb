require_relative '../../lib/sports/sportsList'
require_relative '../../lib/events/normalEvent'
require_relative '../../lib/users/bookie'
require 'test/unit'

class SportsList_Tests < Test::Unit::TestCase

   def setup
      @sports = Sports::SportsList.new
      @football = Sports::Football.new("Football")
      @sports.addSport(@football.name, @football)
      @ne = Events::NormalEvent.new(1,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @sports.addEvent(@football.name, @ne)
      @b = Users::Bookie.new("Filipe","f@gmail.com","12345")
   end


   ## addSport tests
   def test_addSport1
      assert_equal(1, @sports.sports.size())
   end

   ## addEvent tests
   def test_addEvent1
      assert_equal(1,@sports.sports[@football.name].events.size())
   end

   def test_addEvent2
      football =  @sports.sports[@football.name]
      assert_equal(true, football.containsEvent(1))
   end

   ## removeEvent tests
   def test_removeEvent1
      @sports.removeEvent(1)
      football =  @sports.sports[@football.name]
      assert_equal(false, football.containsEvent(1))
   end

   def test_removeEvent2
      event = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @sports.addEvent(@football.name, event)
      @sports.removeEvent(1)
      football =  @sports.sports[@football.name]
      assert_equal(true, football.containsEvent(2))
   end

   def test_removeEvent3
      event = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @sports.addEvent(@football.name, event)
      @sports.removeEvent(1)
      @sports.removeEvent(2)
      football =  @sports.sports[@football.name]
      assert_equal(0, football.events.size())
   end

   ## getAllEvents tests
   def test_getAllEvents1
      events = @sports.getAllEvents
      assert_equal(1, events.size())
   end

   def test_getAllEvents2
      footballEvents = @sports.getAllEvents[@football.name]
      assert_equal(1, footballEvents.length)
   end

   def test_getAllEvents3
      footballEvents = @sports.getAllEvents[@football.name]
      assert_equal(true, footballEvents.has_key?(1))
   end

   def test_getAllEvents4
      footballEvents = @sports.getAllEvents[@football.name]
      assert_equal(false, footballEvents.has_key?(2))
   end

   def test_getAllEvents5
      event = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @sports.addEvent(@football.name, event)
      footballEvents = @sports.getAllEvents[@football.name]
      assert_equal(true, footballEvents.has_key?(2))
   end


   ## slDisplayOddsFrom tests
   def test_slDisplayOddsFrom1
      odds = @sports.slDisplayOddsFrom(1)
      assert_equal(true, (1.5==odds[0].odd && 5==odds[1].odd && 2==odds[2].odd))
   end

   ## slChangeOddsTo tests
   def test_slChangeOddsTo1
      @sports.slChangeOddsTo(1,[10,9,8])
      odds = @sports.slDisplayOddsFrom(1)
      assert_equal(true, (10==odds[0].odd && 9==odds[1].odd && 8==odds[2].odd))
   end


   ## mapOfAllEvents tests
   def test_mapOfAllEvents1
      events = @sports.mapOfAllEvents
      assert_equal(1, events.length)
   end

   def test_mapOfAllEvents2
      events = @sports.mapOfAllEvents
      assert_equal(true, events.has_key?(1))
   end

   def test_mapOfAllEvents3
      event = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @sports.addEvent(@football.name, event)
      events = @sports.mapOfAllEvents
      assert_equal(2, events.length)
   end

   def test_mapOfAllEvents4
      event = Events::NormalEvent.new(2,"FC Porto x SC Braga", "j@gmail.com",1.5,2,5)
      @sports.addEvent(@football.name, event)
      events = @sports.mapOfAllEvents
      assert_equal(true, (events.has_key?(1) && events.has_key?(2)))
   end











end
