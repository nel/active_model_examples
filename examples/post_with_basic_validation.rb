require 'load_dependencies'

class PostWithBasicValidation < Post
  include ActiveModel::Validations

  validates_presence_of :title
end

p = PostWithBasicValidation.new(:body => 'this is my body')

p.valid? #=> false

p.errors.size #=> 1

p.errors.full_messages #=> ["Title translation missing: en-US, errors, models, post_with_basic_validation, attributes, title, blank"]

p = PostWithBasicValidation.new(:body => 'this is my body', :title => 'title')

p.valid? #=> true