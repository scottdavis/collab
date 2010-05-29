class Asset < ActiveRecord::Base
  acts_as_taggable
  class User < ActiveRecord::Base
      has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
    end
end
