class Goal < ApplicationRecord
  validates :title, :detail, :private, :complete, presence: true

  belongs_to :user
end
