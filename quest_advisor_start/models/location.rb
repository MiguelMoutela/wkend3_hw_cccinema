require_relative("../db/sql_runner")
require_relative("./user")

class Location

  attr_reader :id
  attr_accessor :name, :category

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @category = options['category']
  end

  def save()
    sql = "INSERT INTO locations
    (
      name,
      category
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @category]
    location = SqlRunner.run( sql, values ).first
    @id = location['id'].to_i
  end

  def user
    sql = "SELECT users.* FROM users
           INNER JOIN visits
           ON users.id = visits.users_id
           WHERE location_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    users = results.map{|result| User.new(result)}
    return users
  end

  def self.all()
    sql = "SELECT * FROM locations"
    values = []
    locations = SqlRunner.run(sql, values)
    result = locations.map { |location| Location.new( location ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM locations"
    values = []
    SqlRunner.run(sql, values)
  end

end
