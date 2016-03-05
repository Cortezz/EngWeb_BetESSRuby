require_relative 'facade.rb'

b = Facade.new
b.fAddPunter("user","user@gmail.com","12345")
b.fAddOpenBetTo(1,"user@gmail.com")
b.fAddBet(1,"user@gmail.com",1,2.55,400)
puts b.fBetHistoryFrom("user@gmail.com")
