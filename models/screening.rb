require_relative('..db/sql_runner.rb')
require_relative('./ticket.rb')

class Screening

  attr_reader(:id)
  attr_accessor(:movie_id, :screening_time, :tickets_bought)

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @movie_id = options['movie_id']
    @screening_time = options['screening_time']
  end



end
