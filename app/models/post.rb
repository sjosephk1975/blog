class Post < ApplicationRecord
  enum status: {draft:0, published: 1}
  belongs_to :user
  def self.by_date
    order('created_at DESC')
  end
end
