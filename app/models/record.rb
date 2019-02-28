class Record < ApplicationRecord
  belongs_to :user

  validates :title, :year, precense: true
end
