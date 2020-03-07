# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  venue_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Venue < ApplicationRecord
  has_many :venuefollows, :dependent => :destroy
  has_many :shows, :foreign_key => "host_id", :dependent => :destroy
end
