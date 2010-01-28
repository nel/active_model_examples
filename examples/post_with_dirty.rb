require 'load_dependencies'

class PostWithDirty < Post
  include ActiveModel::Dirty
 
  define_attribute_methods [:title]
 
  def title=(title)
    title_will_change!
    @attributes[:title] = title
  end
 
  def save
    super
    @previously_changed = changes
  end
 
end

p = PostWithDirty.new(:title => 'initial title')

p.changed? #=> true
p.title_changed? #=> true

p.save

p.changed? #=> false
p.title_changed? #=> false

p.title = 'new title'

p.changed? #=> true
p.title_changed? #=> true
p.title_was #=> 'initial title'
p.title_change #=> ['initial title','new title']