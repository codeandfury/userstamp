class Post < ActiveRecord::Base
  stampable :stamper_class_name => :user
end