class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :email, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  has_many :authorizations
  has_many :jobs
  has_many :applications

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(provider: auth.provider,
                                        uid: auth.uid.to_s,
                                        token: auth.credentials.token,
                                        secret: auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where(email: auth['info']['email']).first : current_user
      nickname = auth.info.nickname
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0, 20]
        user.username = User.find_by(username: nickname) ? "#{nickname}_#{auth.provider}" : nickname
        user.name = auth.info.name
        user.email = auth.info.email
        user.save
      end
      authorization.username = nickname
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end

  def self.new_with_session(params, session)
    if session['devise.user_data']
      new(session['devise.user_data']) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
end
