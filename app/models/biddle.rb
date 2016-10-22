# This class is written by a paid staff developer who understands the services offered by the CoC

class Biddle < Coc
  def services(user)
    if user.vet_status then [:meal] else [] end
  end
end
