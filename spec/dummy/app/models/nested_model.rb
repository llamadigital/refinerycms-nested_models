class NestedModel < ActiveRecord::Base
  belongs_to :page, class_name: 'Refinery::Page'
  belongs_to :image, class_name: 'Refinery::Image'
  attr_accessible :position, :name, :image_id
end
