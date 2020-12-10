class Broadcast < ApplicationRecord
  has_many :testers, counter_cache: true
end
