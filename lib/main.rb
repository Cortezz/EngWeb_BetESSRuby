$LOAD_PATH << '.'
require_relative './users/bookie'

u = Users::Bookie.new("José Cortez","jose@gmail.com","12345")
u.subscribeTo(2)
puts u.toString
