class User < ActiveRecord::Base
  has_many :watch_lists,
    primary_key: :id,
    foreign_key: :user_id,
    source: :User

  has_many :watch_list_items,
    through: :watch_lists,
    source: :watch_list_items

  has_many :watched_companies,
    Proc.new { distinct },
    through: :watch_list_items,
    source: :company
end
