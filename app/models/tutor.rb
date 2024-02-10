class Tutor < ApplicationRecord
  belongs_to :course
  validates :name, :experience, presence: true
  validates_uniqueness_of :name, case_sensitive: false
end
