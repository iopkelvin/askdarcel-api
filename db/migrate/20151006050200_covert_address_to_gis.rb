class CovertAddressToGis < ActiveRecord::Migration
  def self.up
    add_column :addresses, :lonlat, :st_point, geographic: true, srid: 4326

    execute <<-SQL
      UPDATE addresses SET lonlat = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);
    SQL

    remove_column :addresses, :latitude
    remove_column :addresses, :longitude
  end

  def self.down
    add_column :addresses, :latitude, :float
    add_column :addresses, :longitude, :float

    execute <<-SQL
      UPDATE addresses SET longitude = ST_X(ST_TRANSFORM(lonlat::geometry, 4326));
      UPDATE addresses SET latitude = ST_Y(ST_TRANSFORM(lonlat::geometry, 4326));
    SQL

    remove_column :addresses, :lonlat
  end
end
