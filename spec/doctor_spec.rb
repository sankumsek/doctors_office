require 'pg'
require 'rspec'
require 'doctor.rb'

describe 'Doctor' do
  it 'initializes doctor name' do
    doctor = Doctor.new('doctor' => 'Dr. Seuss')
    expect(doctor).to be_an_instance_of Doctor
  end
end
