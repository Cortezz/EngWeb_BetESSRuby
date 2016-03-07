$LOAD_PATH << '.'
require_relative 'user'
require 'set'

module Users

  class Bookie < User

     attr_reader :subscribedEvents

    def initialize(name, email, pwd)
      super(name,email,pwd)
      @subscribedEvents = Set.new([])
    end

    ################ EVENTS ##################

    # Adds an event to the bookie's subscribed events list
    def subscribeTo (event)
      @subscribedEvents.add(event)
    end

    # Removes an event, given its ID, from the subscribed events list
    def unsubscribeTo (event)
      @subscribedEvents.delete?(event)
    end

    # Returns the amount of subscribed events
    def amountOfSubscribedEvents
      @subscribedEvents.length
    end
    ############# OBSERVER Methods ###########

    def update (event)
      if (event.outcome == -1)
         s = "The odds of an event you've subscribed to have changed!\n"
         s << event.toString
      else
         s = "An event you've subscribed to has ended!\n"
         s << event.toString
         s << "Gains: #{event.gains} coins.\n"
         s << "Losses: #{event.losses} coins.\n"
      end
      @notifications.push(s)
    end
    #########################################

    def toString
      s = super + "Subscribed events: "
      @subscribedEvents.each {|event| s << event.to_s << ";"}
      s
    end


  end
end
