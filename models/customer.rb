require_relative("../db/sql_runner")
require_relative("./film")

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
            INNER JOIN tickets
            ON films.id = tickets.film_id
            WHERE tickets.customer_id = $1"
    values = [@id]
    films_hashes = SqlRunner.run(sql, values)
    return films_hashes.map {|film_hash| Film.new(film_hash)}
  end

end
