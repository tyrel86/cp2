class Right < ActiveRecord::Base
  attr_accessible :operation, :resource

  has_many :grants
  has_many :roles, through: :grants
  
  OPERATION_MAPPINGS = {
    "new" => "CREATE",
    "create" => "CREATE",
    "edit" => "UPDATE",
    "update" => "UPDATE",
    "destroy" => "DELETE",
    "show" => "READ",
    "index" => "READ",
    "search" => "READ",
    "user_index" => "MANAGE",
    "backend_show" => "MANAGE",
    "backend_search" => "MANAGE",
    "manage" => "MANAGE",
    "home" => "HOME"
  }
end
