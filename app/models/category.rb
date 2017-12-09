class Category < ActiveYaml::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  set_root_path "db/data"
end
