require 'load_dependencies'

class PostWithCallBack < Post
  extend ActiveModel::Callbacks
  define_model_callbacks :save
 
  before_save :generate_id_if_missing
    
  def save
    _run_save_callbacks do
      super
    end
  end
  
  def id
    @attributes[:id]
  end
  
private
  def generate_id_if_missing
    @attributes[:id] ||= rand(100_000) 
  end
end

p = PostWithCallBack.new(:title => 'test')

p.id #=> nil

p.save

p.id #=> 23_339