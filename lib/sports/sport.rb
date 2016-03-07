$LOAD_PATH << "."
require_relative '../events/normalEvent'

module Sports
   class Sport

      attr_reader :name
      attr_reader :events

      def initialize (name)
         @name = name
         @events = Hash.new
      end

      ## Checks whether or not a certain event exists.
      def containsEvent (eventID)
         @events.has_key?(eventID)
      end

      ## Returns the odds of all outcomes from a certain event.
      def displayOddsFrom (eventID)
         @events[eventID].displayOdds
      end

      ## Changes the odds of an event.
      def changeOddsTo (eventID, newOdds)
         @events[eventID].changeOdds(newOdds)
      end

      ## Removes an event.
      def removeEvent (eventID)
         if (@events.has_key?(eventID))
            @events.delete(eventID)
         end
      end

      ## Adds a bookie to an event's observer list
      def addSubscribedBookieTo(eventID, bookie)
         events[eventID].addObserver(bookie)
      end


   end
end
