class Subdomain
  def self.matches?(request)

    case request.host
    when Rails.application.domain, "www.#{Rails.application.domain}", nil
      false
    else
      true
    end  
  end
end
