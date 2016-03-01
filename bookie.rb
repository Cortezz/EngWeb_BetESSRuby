$LOAD_PATH << '.'
require 'user'
require 'set'

class Bookie < User

  def initialize(name, email, pwd)
    @name = name
    @email = email
    @password = pwd
    @subscribedEvents = Set.new([])
  end

  ## Getters
  def getSubscribedEvents
    @subscribedEvents
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
  #########################################

  def toString
    s = super + "Subscribed events: "
    @subscribedEvents.each {|event| s << event.to_s << ";"}
    s
  end


end
