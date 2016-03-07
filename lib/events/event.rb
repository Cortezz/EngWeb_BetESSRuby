require_relative '../observer/subject'
module Events

   class Event
      include Subject

      attr_accessor :description
      attr_accessor :gains
      attr_accessor :losses
      attr_accessor :eventID
      attr_accessor :bookie
      attr_reader :outcome
      attr_reader :bets

      def initialize (id, description, bookie)
         super()
         @description = description
         @gains = @losses = 0
         @eventID = id
         @bookie = bookie
         @outcome = -1
         @bets = Set.new([])
      end


      ## Closes an event by changing its outcome (from -1 to some other value).
      def closeEvent (outcome)
         @outcome = outcome
         notifyObservers()
      end

      ## Adds a bet to this event.
      def addBet (betID)
         @bets.add(betID)
      end

      def toString
         s = "Event ID: " << @eventID.to_s << "\n"
         s << "Description: "  << @description << "\n"
         if (@outcome != -1)
            s << "Oucome: " << @outcome.to_s << "\n"
         end
         s
      end


   end

end
