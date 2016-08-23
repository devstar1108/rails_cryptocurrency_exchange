class Notification < ActiveRecord::Base
  validates_presence_of :notification_text, :notification_color
  validates :link, :url => true, :presence => false
end
