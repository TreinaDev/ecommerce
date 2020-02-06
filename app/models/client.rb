class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum client_type: { personal: 0, company: 15 }
  validates :name, :address, :zip_code, :client_type, :document, presence: { message: 'deve ser informado' }
end
