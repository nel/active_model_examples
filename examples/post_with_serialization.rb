require 'load_dependencies'

class PostWithSerialization < Post
  include ActiveModel::Serializers::JSON
  
  attr_accessor :attributes
  
  def body
    @attributes[:body]
  end
  
  def id
    @attributes[:id]
  end
  
  def attributes
    @attributes.inject({}) do |hash, (key,value)|
      hash[key.to_s] = value
      hash
    end
  end
end

PostWithSerialization.clear

#Create tree posts
3.times do |i|
  PostWithSerialization.new(:title => "PostTitle#{i}", :body => "body#{i}", :id => i).save
end

#List them
PostWithSerialization.all.map &:to_json #=> ["{\"title\":\"PostTitle0\",\"body\":\"body0\",\"id\":\"0\"}", "{\"title\":\"PostTitle1\",\"body\":\"body1\",\"id\":\"1\"}", "{\"title\":\"PostTitle2\",\"body\":\"body2\",\"id\":\"2\"}"]

PostWithSerialization.all.first.to_json(:except => :id) #=> "{\"title\":\"PostTitle0\",\"body\":\"body0\"}"

PostWithSerialization.new.from_json(PostWithSerialization.all.first.to_json) #=> #<PostWithSerialization:0x101111690 @attributes={"body"=>"body0", "title"=>"PostTitle0", "id"=>"0"}>