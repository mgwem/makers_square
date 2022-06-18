class Relationship < ApplicationRecord

  belongs_to :following, class_name: "Member"
  belongs_to :followed, class_name: "Member"
end
