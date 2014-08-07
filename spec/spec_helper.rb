require 'rspec'
require 'pg'
require 'doctor'

DB = PG.connect({:dbname => 'doc_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patient *;")
    DB.exec("DELETE FROM insurance *;")
    DB.exec("DELETE FROM specialty *;")
    DB.exec("ALTER SEQUENCE specialty_id_seq RESTART WITH 1;")
  end
end
