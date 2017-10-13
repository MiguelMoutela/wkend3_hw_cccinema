require_relative("../db/sql_runner")


class Ticket

  attr_reader(:id)
  attr_accessor(:customer_id, :movie_id)

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @movie_id = options['movie_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, movie_id)
          VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @movie_id]
    ticket = SqlRunner.run(sql, values).first
        ##ask whether I need that .first since it is not a class method
    @id = ticket['id'].to_i
  end

    def self.all()
      sql = "SELECT * FROM tickets"
      values = []
      tickets = SqlRunner.run(sql, values)
      result = tickets.map { |ticket| Ticket.new(ticket) }
      return result
    end

    def update
      sql = "UPDATE tickets
            SET (customer_id, movie_id) = ($1, $2)
            WHERE id = $3"
      values = [@customer_id, @movie_id, @id]
      SqlRunner.run(sql, values)
      return nil
    end

    def self.delete_all()
      sql = "DELETE FROM tickets"
      values = []
      SqlRunner.run(sql, values)
    end

    def delete
      sql = "DELETE FROM tickets
            WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
      return nil
    end

end
