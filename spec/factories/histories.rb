FactoryGirl.define do
  factory :history do
    user nil
    needs_shelter false
    rating 1
    fleeing false
    incarcerated false
    welfare false
    insufficent_income false
    alcohol_or_drug_abuse false
    physical_health_issue false
    mental_health_issue false
    exchange_for_sex false
  end
end
