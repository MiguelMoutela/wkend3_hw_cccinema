require_relative("../db/sql_runner")
require('pry')


class Movie

  attr_reader(:id)
  attr_accessor(:title, :price)

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO movies (title, price)
          VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    movie = SqlRunner.run(sql, values).first

    #  binding.pry
        ##ask whether I need that .first since it is not a class method
    @id = movie['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM movies"
    values = []
    movies = SqlRunner.run(sql, values)
    result = movies.map { |movie| Movie.new(movie) }
    return result
  end

  def update
    sql = "UPDATE movies
          SET (title, price) = ($1, $2)
          WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
    return nil
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM movies
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
    return nil
  end

  def customers
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON customers.id = tickets.customer_id
          WHERE movie_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    customers = result.map {|customer| Customer.new(customer)}
    return customers
  end

end
