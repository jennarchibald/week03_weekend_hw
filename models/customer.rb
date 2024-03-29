require_relative("../db/sql_runner")
require_relative("./film")
require_relative("./ticket")

class Customer
  attr_reader :id
  attr_accessor :name, :funds
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  # create
  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  # read

  def self.all
    sql = "SELECT * FROM customers"
    customers_hashes = SqlRunner.run(sql)
    return customers_hashes.map {|customer_hash| Customer.new(customer_hash)}
  end

  # update

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  # delete

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  # films a customer has bought tickets for

  def films
    sql = "SELECT films.*
    FROM films
    INNER JOIN screenings
    ON films.id = screenings.film_id
    INNER JOIN tickets
    ON screenings.id = tickets.screening_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films_hashes = SqlRunner.run(sql, values)
    return films_hashes.map {|film_hash| Film.new(film_hash)}
  end


  # Check how many tickets were bought by a customer

  def how_many_tickets()
    sql = "SELECT COUNT(customer_id) FROM tickets WHERE customer_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).first['count'].to_i
  end


  # buying ticket for a film reducing customers funds

  # def buy_ticket_for_film(film)
  #   price = film.price
  #   @funds -= price
  #   self.update()
  #   ticket = Ticket.new({'customer_id' => @id, 'film_id' => film.id})
  #   ticket.save()
  # end

  def buy_ticket_for_screening(screening)

  remaining_seats = screening.available_seats()

    if remaining_seats == 0
      return "Sold Out"
    else

      sql = "SELECT films.price
      FROM films
      INNER JOIN screenings
      ON films.id = screenings.film_id
      WHERE screenings.id = $1"
      values = [screening.id]
      price = SqlRunner.run(sql, values).first['price'].to_i

      @funds -= price
      update()

      ticket = Ticket.new({'customer_id' => @id, 'screening_id' => screening.id})
      ticket.save()

      screening.available_seats -= 1
      screening.update
      return "Ticket sold"
    end
  end

end
