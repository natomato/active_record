require_relative './db_connection'

module Searchable
  def where( params )
    search = params.map { |col_name, _| "#{col_name} = ?" }.join(" AND ")

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT *
      FROM #{table_name}
      WHERE #{search}
    SQL

    parse_all(results)
  end

end