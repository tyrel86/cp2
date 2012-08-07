class Role < ActiveRecord::Base
  attr_accessible :name
  has_many :grants
  has_many :assignments
  has_many :users, through: :assignments
  has_many :rights, through: :grants
  scope :for, lambda{ | action , resource |
                    where( "rights.operation = ? and rights.resource = ?",
                      Right::OPERATION_MAPPINGS[action], resource )
                      }
end
