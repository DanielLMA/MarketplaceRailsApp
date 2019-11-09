class Runner < ApplicationRecord
  rolify
    has_one_attached :image
end
