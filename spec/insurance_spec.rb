require 'spec_helper'
require 'insurance.rb'
require 'pg'
require 'rspec'

DB = PG.connect({:dbname => 'doc_office_test'})

describe 'Insurance' do
  it 'initializes' do
    insurance = Insurance.new({:company=>'Red Shield'})
    expect(insurance).to be_an_instance_of Insurance
  end

  it 'empty array' do
    expect(Insurance.all).to eq []
  end

  it 'saves' do
    insurance1 = Insurance.new({:company=>'Swag Farm'})
    insurance1.save
    insurance2 = Insurance.new({:company=>'Red Shield'})
    insurance2.save
    insurance3 = Insurance.new({:company=>'Advantage'})
    insurance3.save
    expect(Insurance.all).to eq [insurance1, insurance2, insurance3]
  end

  it 'removes' do
    insurance = Insurance.new({:company=>'Red Shield'})
    insurance.save
    insurance.remove
    expect(Insurance.all).to eq []
  end
end
