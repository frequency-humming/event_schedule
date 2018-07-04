class Event < ActiveRecord::Base
  belongs_to :user
  
  has_many :messages, dependent: :destroy

  has_many :events_attendings, dependent: :destroy

  has_many :users, through: :events_attendings
end
