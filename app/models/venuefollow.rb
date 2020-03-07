# == Schema Information
#
# Table name: venuefollows
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  venue_id   :integer
#

class Venuefollow < ApplicationRecord
  belongs_to :fan, :class_name => "User"
  belongs_to :venue
end
