require 'spec_helper'

describe 'patient' do

  it 'initializes' do
    patient = Patient.new({:name=>'Seuss', :birthdate=>'1960-05-12'})
    expect(patient).to be_an_instance_of Patient
  end

    it 'blank array' do
      expect(Patient.all).to eq []
  end

  it 'saves' do
    patient = Patient.new({:name=>'Seuss', :birthdate=>'1960-05-12'})
    patient.save
    expect(Patient.all[0]).to eq patient
  end

  it 'assigment' do
    new_doctor = Doctor.new({:name=>'Seuss', :specialty=>1})
    new_doctor.save
    patient = Patient.new({:name=>'Seuss', :birthdate=>'1960-05-12'})
    patient.save
    patient.assign_doctor(new_doctor.id)
    expect(patient.doctor_id).to eq new_doctor.id
  end

  it 'removes' do
    patient = Patient.new({:name=>'Seuss'})
    patient.save
    patient.remove
    expect(Patient.all).to eq []
  end
end
