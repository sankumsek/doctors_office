class Patient

  attr_reader :name, :birthdate, :id, :doctor_id

  def initialize attributes
    @name = attributes[:name]
    @birthdate = attributes[:birthdate]
    @id = attributes[:id]
    @doctor_id = attributes[:doctor_id]
  end

  def self.all
    patients = []
    results = DB.exec("SELECT * FROM patient;")
    results.each do |result|
      attributes = {
        :name => result['name'],
        :birthdate => result['birthdate'],
        :id => result['id'].to_i,
        :doctor_id => result['doctor_id'].to_i
      }
      patients << Patient.new(attributes)
    end
    patients
  end

  def save
    results = DB.exec("INSERT INTO patient (name) VALUES ('#{name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def assign_doctor number
    DB.exec("UPDATE patient SET doctor_id = #{number} WHERE id = #{id};")
    @doctor_id = number
  end

  def remove
    DB.exec("DELETE FROM patient WHERE id = #{id}")
  end

  def == another_patient
    self.name == another_patient.name && self.id == another_patient.id
  end
end
