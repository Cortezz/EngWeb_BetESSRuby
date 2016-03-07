$LOAD_PATH << '.'
require_relative 'sport'

module Sports

   class SportsList

      attr_reader :eventCount
      attr_reader :sports

      def initialize
         @eventCount = 1
         @sports = Hash.new
      end


      ## Adds a sport into the system.
      def addSport(name, sport)
         @sports[name] = sport
      end

      ## Adds an event, from a certain sport, to the system.
      def addEvent(name, event)
         @sports[name].addEvent(event)
         @eventCount +=1
      end


      ## Removes an event from the system.
      def removeEvent (event)
         @sports.each do |name,sport|
            events = sport.events
            if (events.has_key?(event))
               sport.removeEvent(event)
            end
         end
      end

      ## The events are mapped according to the sport they represent. This method returns a single collection with all events in it.
      def getAllEvents
         result = Hash.new
         @sports.each do |name,sport|
            events = Hash.new
            result[name] = events
            aux = sport.events
            aux.each do |eventID, event|
               result[name][eventID]=event
            end
         end
         result
      end

      ## dds a bookie to an event's observers list.
      def subscribeBookieToEvent (eventID, bookie)
         @sports.each do |name,sport|
           if (sport.containsEvent(eventID))
               sport.addSubscribedBookieTo(eventID,bookie)
           end
         end
      end

      ## Returns the odds of all outcomes from a certain event.
      def slDisplayOddsFrom (eventID)
         @sports.each do |name,sport|
            if (sport.containsEvent(eventID))
               return sport.displayOddsFrom(eventID)
            end
         end
      end

      ## Changes the odds of an event.
      def slChangeOddsTo (eventID, newOdds)
         @sports.each do |name,sport|
            if (sport.containsEvent(eventID))
               sport.changeOddsTo(eventID,newOdds)
            end
         end
      end

      ## Returns all events in string representation
      def displayEvents
         events = self.getAllEvents
         s  = "List of events\n\n"
         events.each do |sportname, sport|
            s << "\t\t" << sportname << "\n"
            sport.each do |eventID, event|
               s << event.toString << "---\n"
            end
         end
         s
      end

      ## Returns a map with every existing event, mapped according to its ID.
      def mapOfAllEvents
         events = self.getAllEvents
         result = Hash.new

         events.each do |sport, evs|
            evs.each do |eventID, event|
               result[eventID] = event
            end
         end
         result
      end

   end

end
