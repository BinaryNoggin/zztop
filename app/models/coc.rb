# Subclasses are written by a paid staff developer who understands the services offered by the CoC

class Coc
  def services(user)
    raise "subclasses of CoC must implement #services method"
  end
  def self.find_services(user)
    [Biddle, CenterForWomenAndFamilies].map do |coc|
      {
        coc: coc,
        services: coc.new.services(user)
      }
    end
  end
end
