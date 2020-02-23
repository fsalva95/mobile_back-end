class JsonWebToken
 class << self
   def encode(payload, exp = 24.hours.from_now)
     payload[:exp] = exp.to_i
     JWT.encode(payload, ENV['SECRET_KEY_BASE'])   #Rails.application.secrets.secret_key_base in localhost
                                                                      #ENV['SECRET_KEY_BASE'] in heroku
   end

   def decode(token)
     body = JWT.decode(token, ENV['SECRET_KEY_BASE'])[0] #Rails.application.secrets.secret_key_base
     HashWithIndifferentAccess.new body                                      #ENV['SECRET_KEY_BASE'] in heroku
   rescue
     nil
   end
 end
end
