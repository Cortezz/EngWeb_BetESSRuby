$LOAD_PATH << '.'
require_relative 'sport'

module Sports

   class Football < Sport

      def initialize (name)
         super(name)
      end


      # Adds a NormalEvent (1/X/2) related to Football.
      def addEvent (e)
         @events[e.eventID] = e
      end
   end

end
