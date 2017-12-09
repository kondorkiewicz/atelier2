class Category < ActiveYaml::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  set_root_path "db/data"

  def books
    ::Book.where(category_id: self.id)
  end
end
