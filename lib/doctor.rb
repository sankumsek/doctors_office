class Doctor
attr_reader :name

def initialize attributes
  @name = attributes[:name]
end

def name
  @name
end

end
