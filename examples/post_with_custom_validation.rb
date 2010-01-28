require 'load_dependencies'

class ExternalLinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'should not have links' if value =~ /http/
  end
end

class PostWithCustomValidation < Post
  include ActiveModel::Validations

  validates :title, :external_link => true
end

p = PostWithCustomValidation.new(:title => 'this is my title')

p.valid? #=> true

p.errors.size #=> 0

p = PostWithCustomValidation.new(:title => 'this is my title with a link http://w3fu.com')

p.valid? #=> false

p.errors.full_messages #=> ["Title should not have links"]