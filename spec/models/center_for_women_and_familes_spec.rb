require 'rails_helper'
require 'center_for_women_and_families'

RSpec.describe CenterForWomenAndFamilies do
  it 'takes any children' do
    child = User.create(dob: Date.today - 6.years, sex: 'Male')
    services = CenterForWomenAndFamilies.new.services(child)
    expect(services).to eql([:housing])
  end
  it 'takes any women' do
    woman = User.create(dob: Date.today - 6.years, sex: 'Female')
    services = CenterForWomenAndFamilies.new.services(woman)
    expect(services).to eql([:housing])
  end
  it 'rejects adult men' do
    man = User.create(dob: Date.today - 65.years, sex: 'Male')
    services = CenterForWomenAndFamilies.new.services(man)
    expect(services).to eql([])
  end
end
