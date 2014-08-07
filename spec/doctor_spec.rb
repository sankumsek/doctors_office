require 'pg'
require 'rspec'
require 'doctor.rb'
require 'spec_helper'
require 'patient.rb'

DB = PG.connect({:dbname => 'doc_office_test'})

describe 'Doctor' do
  it 'initializes' do
    doctor = Doctor.new({:name=>'Seuss', :specialty=>1})
    expect(doctor).to be_an_instance_of Doctor
  end


  it 'blank array' do
      expect(Doctor.all).to eq []
  end


  it 'saves' do
    doctor = Doctor.new({:name=>'Seuss', :specialty=>1})
    doctor.save
    expect(Doctor.all[0]).to eq doctor
  end

  it 'new specialty' do
    doctor = Doctor.new({:name=>'Seuss', :specialty=>1})
    doctor.save
    doctor.edit_specialty(2)
    expect(doctor.specialty).to eq 2
  end

  it 'given specialty' do
    doctor1 = Doctor.new({:name=>'Seuss'})
    doctor1.save
    doctor1.edit_specialty(1)
    doctor2 = Doctor.new({:name=>'Sterling'})
    doctor2.save
    doctor2.edit_specialty(2)
    doctor3 = Doctor.new({:name=>'Jeevs'})
    doctor3.save
    doctor3.edit_specialty(2)
    expect(Doctor.list_by_specialty(2)).to eq [doctor2, doctor3]
  end

  it 'changes insurance' do
    doctor = Doctor.new({:name=>'Seuss', :specialty=>1})
    doctor.save
    doctor.edit_insurance(1)
    expect(doctor.insurance).to eq 1
  end

  it 'all doctors that accept given insurance' do
    doctor1 = Doctor.new({:name=>'Seuss'})
    doctor1.save
    doctor1.edit_insurance(1)
    doctor2 = Doctor.new({:name=>'Sterling'})
    doctor2.save
    doctor2.edit_insurance(1)
    doctor3 = Doctor.new({:name=>'Jeevs'})
    doctor3.save
    doctor3.edit_insurance(2)
    expect(Doctor.list_by_insurance(1)).to eq [doctor1, doctor2]
  end

  it 'removes' do
    doctor = Doctor.new({:name=>'Seuss'})
    doctor.save
    doctor.remove
    expect(Doctor.all).to eq []
  end

  it 'number of patients assigned to a doctor' do
    doctor = Doctor.new({:name=>'Seuss'})
    doctor.save
    patient1 = Patient.new({:name=>'Sterling'})
    patient1.save
    patient1.assign_doctor(doctor.id)
    patient2 = Patient.new({:name=>'Jill'})
    patient2.save
    patient2.assign_doctor(doctor.id)
    expect(doctor.patient_count).to eq 2
  end

  it 'returns all doctors with a patient count' do
    doctor1 = Doctor.new({:name=>'Seuss'})
    doctor1.save
    doctor2 = Doctor.new({:name=>'Seuss'})
    doctor2.save
    patient1 = Patient.new({:name=>'Sterling'})
    patient1.save
    patient1.assign_doctor(doctor1.id)
    patient2 = Patient.new({:name=>'Jill'})
    patient2.save
    patient2.assign_doctor(doctor2.id)
    doctor1.patient_count
    doctor2.patient_count
    expect(Doctor.number_of_patients[0].patient_count).to eq 1
    expect(Doctor.number_of_patients[1].patient_count).to eq 1
  end
end
