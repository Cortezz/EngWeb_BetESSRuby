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
    #########################################

    def toString
      s = super + "Subscribed events: "
      @subscribedEvents.each {|event| s << event.to_s << ";"}
      s
    end


  end
end
