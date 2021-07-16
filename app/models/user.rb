class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  attachment :profile_image
  
  validates :name, 
    lenge: {minimum: 2, maximum: 20}
    
  validates :introduction,
    lenge: {maximum: 50}
  
  
  def fuga
     
  end
  
end
