require('pry-byebug')
require_relative("../models/customer")
require_relative("../models/film")
require_relative("../models/ticket")
require_relative("../models/screening")

Ticket.delete_all
Customer.delete_all
Film.delete_all



customer1 = Customer.new({'name' => 'Jenn', 'funds' => '200'})
customer1.save()

customer2 = Customer.new({'name' => 'Becky', 'funds' => '200'})
customer2.save()

customer3 = Customer.new({'name' => 'Amy', 'funds' => '200'})
customer3.save()

customer4 = Customer.new({'name' => 'Pim', 'funds' => '200'})
customer4.save()




film1 = Film.new({'title' => 'Avengers', 'price' => '10'})
film1.save()

film2 = Film.new({'title' => 'The Matrix', 'price' => '8'})
film2.save()

screening1 = Screening.new({'show_time' => '20:00:00', 'available_seats' => '20', 'film_id' => film1.id})
screening1.save()
screening2 = Screening.new({'show_time' => '20:00:00', 'available_seats' => '10', 'film_id' => film2.id})
screening2.save()
screening3 = Screening.new({'show_time' => '09:00:00', 'available_seats' => '10', 'film_id' => film1.id})
screening3.save()
screening4 = Screening.new({'show_time' => '09:00:00', 'available_seats' => '10', 'film_id' => film2.id})
screening4.save()



ticket1 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening1.id})
ticket2.save()

ticket3 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening1.id})
ticket3.save()

ticket4 = Ticket.new({'customer_id' => customer4.id, 'screening_id' => screening1.id})
ticket4.save()

ticket5 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening2.id})
ticket5.save()

ticket6 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening2.id})
ticket6.save()

ticket7 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening3.id})
ticket7.save()




binding.pry()
nil
