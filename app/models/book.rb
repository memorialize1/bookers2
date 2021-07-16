class Book < ApplicationRecord
    
    belongs_to :user
    validates :title, presence: true
    validates :body, 
      lenge: {maximum: 200 }
end
