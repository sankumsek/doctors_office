require 'spec_helper'
require 'specialty.rb'

describe 'Specialty' do
  it 'initializes w/ hash' do
    specialty = Specialty.new({:name=>'Orthopedic'})
    expect(specialty).to be_an_instance_of Specialty
  end

  it 'empty array' do
      expect(Specialty.all).to eq []
  end

  it 'saves' do
    specialty1 = Specialty.new({:name=>'Orthopedic'})
    specialty1.save
    specialty2 = Specialty.new({:name=>'Gynecologist'})
    specialty2.save
    specialty3 = Specialty.new({:name=>'Cardiovascular'})
    specialty3.save
    expect(Specialty.all).to eq [specialty1, specialty2, specialty3]
  end

  it 'removes' do
    specialty = Specialty.new({:name=>'Orthopedic'})
    specialty.save
    specialty.remove
    expect(Specialty.all).to eq []
  end
end
