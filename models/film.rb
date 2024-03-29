require_relative("../db/sql_runner")
require_relative("./customer")
require_relative("./screening")

class Film
  attr_reader :id
  attr_accessor :title, :price
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  # create

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end


  # read

  def self.all()
    sql = "SELECT * FROM films"
    films_hashes = SqlRunner.run(sql)
    return films_hashes.map {|film_hash| Film.new(film_hash)}
  end
  # update

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  # delete

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  # customers who have bought tickets for a film

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    WHERE screenings.film_id = $1"
    values = [@id]
    customers_hashes = SqlRunner.run(sql, values)
    return customers_hashes.map {|customer_hash| Customer.new(customer_hash)}
  end

  # Check how many customers are going to watch a certain film

  def how_many_customers()
    sql = "SELECT COUNT (DISTINCT tickets.customer_id)
    FROM screenings
    INNER JOIN tickets
    On screenings.id = tickets.screening_id
    WHERE screenings.film_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).first['count'].to_i
  end

  # check for most popular screening

  def most_popular_screening()
    sql = "SELECT screenings.*, COUNT(tickets.id) AS number_of_tickets
    FROM screenings
    LEFT JOIN tickets
    ON screenings.id = tickets.screening_id
    WHERE screenings.film_id = $1
    GROUP BY screenings.id
    ORDER BY number_of_tickets DESC
    LIMIT 1"
    values = [@id]
    screening_hash = SqlRunner.run(sql, values).first
    return Screening.new(screening_hash)
  end
end
