# == Schema Information
#
# Table name: showfollows
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :integer
#  show_id     :integer
#

class Showfollow < ApplicationRecord
  belongs_to :attendee, :class_name => "User"
  belongs_to :show
end
