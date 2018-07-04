class User < ActiveRecord::Base
  has_secure_password
  
  has_many :events

  has_many :messages

  has_many :events_attendings
  
  has_many :join_events, through: :events_attendings, source: :events 
end
