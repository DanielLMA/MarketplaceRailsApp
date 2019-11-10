class Profile < ApplicationRecord
  belongs_to :runner
  has_one_attached :image

  validates_uniqueness_of :runner_id
  validates :runner_id, presence: true

  TRAINING_PACE_LIST = [
    "<3min/km", "3-4min/km", "4-5min/km", "5-6min/km",
    "6-7min/km", "7-8min/km", "8-9min/km", "9-10min/km",
    "walking",
  ]

  AGE_RANGE = [
    "<20", "21-29", "30-39", "40-49", "50-59", "60-69", ">70",
  ]

  GENDER_OPTIONS = [
    "male", "female",
  ]

  RUNNING_REGION = ["Brisbane", "Ipswich", "Logan City", "Moreton Bay Region", "Redland City"]

  def self.exclude_blank_profiles
    where.not(username: nil)
  end
end
