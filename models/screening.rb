require_relative("../db/sql_runner")

class Screening
  attr_reader :id
  attr_accessor :show_time, :seats, :film_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @seats = options['seats']
    @film_id = options['film_id']
  end

  # create
  def save()
    sql = "INSERT INTO screenings (show_time, seats, film_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@show_time, @seats, @film_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  # read

  def self.all()
    sql = "SELECT * FROM screenings"
    screening_hashes = SqlRunner.run(sql)
    return screening_hashes.map { |screening_hash| Screening.new(screening_hash)}
  end


  # UPDATE
  def update()
    sql = "UPDATE screenings SET (show_time, seats, film_id) = ($1, $2, $3) WHERE id = $4"
    values = [@show_time, @seats, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  # delete

  def delete
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
