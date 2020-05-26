require('pg')

class Property

    attr_accessor :address, :build, :value, :year_built
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @address = options['address']
        @build = options['build']
        @value = options['value'].to_i
        @year_built = options['year_built'].to_i
    end

    def save()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "INSERT INTO properties
            (address,
            build,
            value,
            year_built)
            VALUES
            ($1, $2, $3, $4)
            RETURNING *;"
        values = [@address, @build, @value, @year_built]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]["id"].to_i
        db.close()
    end

    def delete()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "DELETE FROM properties WHERE id = $1;"
        values = [@id]
        db.prepare("delete_one", sql)
        db.exec_prepared("delete_one", values)
        db.close()
    end

    def Property.all()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "SELECT * FROM properties;"
        db.prepare("all", sql)
        houses = db.exec_prepared("all")
        db.close()
        return houses.map { |house| Property.new(house)}
    end

    def Property.find_id()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "SELECT * FROM properties WHERE id = 9;"
        db.prepare("find", sql)
        houses = db.exec_prepared("find")
        db.close()
        return houses.map { |house| Property.new(house)}
    end

    def Property.find_address()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "SELECT * FROM properties WHERE address = '12 Seasame Street';"
        db.prepare("find", sql)
        houses = db.exec_prepared("find")
        db.close()
        return houses.map { |house| Property.new(house)}
    end

    def Property.delete_all()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "DELETE FROM properties;"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end

    def update()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "UPDATE properties
            SET
            (address, build, value, year_built)
            =
            ($1, $2, $3, $4)
            WHERE id = $5"
        values = [@address, @build, @value, @year_built, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close()
    end

end