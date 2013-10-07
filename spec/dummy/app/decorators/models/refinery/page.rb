Refinery::Page.class_eval do
  has_many :nested_models
  accepts_nested_attributes_for :nested_models, allow_destroy: true
  attr_accessible :nested_models_attributes
end
