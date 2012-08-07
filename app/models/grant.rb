class Grant < ActiveRecord::Base
  attr_accessible :right_id, :role_id
  
  belongs_to :role
  belongs_to :right
end
