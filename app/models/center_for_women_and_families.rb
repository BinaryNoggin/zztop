# This class is written by a paid staff developer who understands the services offered by the CoC

class CenterForWomenAndFamilies < Coc
  def services(user)
    if user.dob + 16.years >= Date.today || !user.male?
      [:housing]
    else
      []
    end
  end
end
