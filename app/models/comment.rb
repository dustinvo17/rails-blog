class Comment < ApplicationRecord
    belongs_to :post
    has_many :comments
    belongs_to :parent, optional: true
    belongs_to :user
    
end
