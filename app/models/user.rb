class User < ApplicationRecord
    has_secure_password


    attr_accessor :activation_token  # aggiunge attributo alla classe User
    before_create :create_activation_digest

    validates :email, uniqueness: true #####################


        # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end



    def self.create_from_auth(email1,name)
      where(email: email1).first_or_initialize do |user|
        user.name = name
        user.email = email1
        user.password= User.digest(User.new_token) #get a random password and encrypt
        user.save!
        user.activate
      end
    end



    def authenticated?(attribute ,token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

        # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

        # Activates an account.
      def activate
        update_attribute(:activated, true)
        #update_attribute(:activated_at, Time.zone.now)
      end

      # Sends activation email.
      def send_activation_email
        UserMailer.account_activation(self).deliver_now
      end


end
