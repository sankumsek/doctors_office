class Insurance
  attr_reader :company, :id

  def initialize attributes
    @company = attributes[:company]
    @id = attributes[:id]
  end

  def self.all
    insurance = []
    results = DB.exec("SELECT * FROM insurance;")
    results.each do |result|
      attributes = {
        :company => result['company'],
        :id => result['id'].to_i
      }
      insurance << Insurance.new(attributes)
    end
    insurance
  end

  def save
    results = DB.exec("INSERT INTO insurance (company) VALUES ('#{company}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def remove
    DB.exec("DELETE FROM insurance WHERE id = #{id}")
  end

  def == another_insurance
    self.company == another_insurance.company && self.id == another_insurance.id
  end
end

