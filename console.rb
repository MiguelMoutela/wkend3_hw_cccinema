require_relative( './models/customer' )
require_relative( './models/movie' )
require_relative( './models/ticket' )
require_relative( './models/screening' )

require('pry')

Ticket.delete_all()
Customer.delete_all()
Movie.delete_all()


customer_1 = Customer.new({'name' => 'Maggy', 'funds' => 10})
customer_1.save()

customer_2 = Customer.new({'name' => 'Harriet', 'funds' => 10})
customer_2.save()

movie_1 = Movie.new({'title' => 'Chicken Escape', 'price' => 5})
movie_1.save()

movie_2 = Movie.new({'title' => 'Run Chicken Run', 'price' => 5})
movie_2.save()


ticket_1 = Ticket.new({'customer_id' => customer_1.id, 'movie_id' => movie_1.id})
ticket_1.save()

ticket_2 = Ticket.new({'customer_id' => customer_2.id, 'movie_id' => movie_2.id})
ticket_2.save()


screening_1 = Screening.new({'movie_id' => movie_1.id, 'time' => '16:00:00'})

screening_2 = Screening.new({'movie_id' => movie_1.id, 'time' => '21:00:00'})

screening_3 = Screening.new({'movie_id' => movie_1.id, 'time' => '21:00:00'})

screening_4 = Screening.new({'movie_id' => movie_2.id, 'time' => '16:00:00'})

screening_5 = Screening.new({'movie_id' => movie_2.id, 'time' => '21:00:00'})

screening_6 = Screening.new({'movie_id' => movie_2.id, 'time' => '21:00:00'})

binding.pry()
nil
