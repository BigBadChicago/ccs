class User < ActiveRecord::Base
  has_many :submissions, :foreign_key => "user_id"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :home_page, :biography, :role

  ROLES = %w[guest attendee speaker admin]

  def admin?
    role? :admin
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
end
