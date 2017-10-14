require_relative("../db/sql_runner")

class Customer

  attr_reader(:id)
  attr_accessor(:name, :funds)

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql,values).first
    ##ask whether I need that .first since it is not a class method
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def update
    sql = "UPDATE customers
          SET (name, funds) = ($1, $2)
          WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
    return nil
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
    return nil
  end

  def movies
    sql = "SELECT movies.*
           FROM movies
           INNER JOIN tickets
           ON movies.id = tickets.movie_id
           WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    movies = results.map{|movie| Movie.new(movie)}
    return movies
  end



  def pay(movie)
  if movie.price > @funds
    return 'not enough funds'
  else
    @funds -= movie.price
    update()
  end
  #   this could be a pay-all method but does not work.. I think the movie in movies is not accessing the movies method.
  #   sql = "UPDATE customers
  #         SET funds = ($1)
  #         WHERE id = ($2)"
  #   bill = []
  #   for movie in movies
  #    bill.push(movies[:price])
  #   end
  #    total = bill.sum
  #   @funds -= total
  #   values = [@funds, @id]
  #   result = SqlRunner.run(sql, values)
  #   return nil

  end

  end
