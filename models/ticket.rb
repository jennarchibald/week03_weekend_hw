require_relative("../db/sql_runner")

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @screening_id = options['screening_id']
  end

  # create
  def save()
    sql = "INSERT INTO tickets (customer_id, screening_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @screening_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end



  # read

  def self.all
    sql = "SELECT * FROM tickets"
    tickets_hashes = SqlRunner.run(sql)
    return tickets_hashes.map {|ticket_hash| Ticket.new(ticket_hash)}
  end

  # update

  def update()
    sql = "UPDATE tickets SET (customer_id, screening_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  # delete

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


end
