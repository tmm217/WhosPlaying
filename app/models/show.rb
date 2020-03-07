# == Schema Information
#
# Table name: shows
#
#  id         :integer          not null, primary key
#  is_soldout :boolean
#  show_bands :string
#  show_date  :datetime
#  show_image :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  host_id    :integer
#

class Show < ApplicationRecord
  has_many :showlikes, :class_name => "Showfollow", :dependent => :destroy
  belongs_to :host, :class_name => "Venue"
end
