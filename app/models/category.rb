class Category < ApplicationRecord
  has_many :posts

  def name_with_branch
    "#{branch}: #{name}"
  end
end
