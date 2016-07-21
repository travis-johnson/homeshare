class List < ActiveRecord::Base
  validates :name, presence: true
  validates :home_id, presence: true
  validates :item, presence: true
  has_many :items 
  belongs_to :home
  belongs_to :user

end
