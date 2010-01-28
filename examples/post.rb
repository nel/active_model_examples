$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'post'

#Clear the data
Post.clear

#Create tree posts
3.times do |i|
  Post.new(:title => "Post Title #{i}", :body => "body#{i}", :id => i).save
end

#List them
Post.all

print Post.all.size, " posts: ", Post.all.map(&:title).join(', ')
