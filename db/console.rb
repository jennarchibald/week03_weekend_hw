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




film1 = Film.new({'title' => 'Avengers', 'price' => '10'})
film1.save()
film2 = Film.new({'title' => 'The Matrix', 'price' => '8'})
film2.save()




ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()




binding.pry()
nil
