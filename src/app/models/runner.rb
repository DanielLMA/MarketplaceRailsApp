class Runner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  rolify

  has_one :profile, dependent: :destroy
  has_many :conversations, :foreign_key => :sender_id
  has_one_attached :image
  
  before_create :create_profile
  after_create :assign_default_role

  accepts_nested_attributes_for :profile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  def create_profile
    profile = build_profile 
  end
  
  def assign_default_role
    self.add_role(:runner) if self.roles.blank?
  end
    
    TRAINING_PACE_LIST = [
     "< 3min/km", "3-4min/km", "4-5min/km", "5-6min/km",
     "6-7min/km", "7-8min/km", "8-9min/km", "9-10min/km",
     "walking"]

     AGE_RANGE = [
       "<20", "21-29", "30-39", "40-49", "50-59", "60-69", ">70"
     ] 

     GENDER_OPTIONS = [
       "male", "female"
     ]
     
end
