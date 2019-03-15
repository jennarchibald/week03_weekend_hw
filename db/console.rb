require('pry-byebug')
require_relative("../models/customer")
require_relative("../models/film")
require_relative("../models/ticket")

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




ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()

ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket3.save()

ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film1.id})
ticket4.save()

ticket5 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket5.save()

ticket6 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket6.save()




binding.pry()
nil
