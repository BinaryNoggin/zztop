# Subclasses are written by a paid staff developer who understands the services offered by the CoC

class Coc
  cattr_accessor :cocs
  attr_reader :name, :filter

  def initialize(name, &filter)
    @name = name
    @filter = filter
    self.class.cocs ||= []
    self.class.cocs << self
  end

  def self.find_for_user(user)
    cocs.map {|coc| {name: coc.name, services: coc.filter.call(user)}}.select {|hash| hash[:services]}
  end
end

Biddle = Coc.new('Biddle House') do |user|
  [:meal, :housing] if user.ssn.present?
end
CFWF = Coc.new('Center for Women and Families') do |user|
  [:housing] if user.older_than?(16) || !user.male?
end
MealsOnWheels = Coc.new('Meals on Wheels') do |_user|
  [:meal]
end


# Booked = Coc.new('Always Booked') do |user|
#   []
# end
# Food = Coc.new('Always Food') do |user|
#   [:meal]
# end
