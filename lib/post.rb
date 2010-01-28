#Very basic blog post model using csv as a storage
#For example only, does not support quoting of ';' or linebreak
class Post
  COLUMNS = [:id, :title, :body]
  
  class << self
    def all
      res = []
      each_line do |l|
        hash = {}
        l.chomp.split(';',COLUMNS.size).each_with_index do |value,index|
          hash[COLUMNS[index]] = value
        end
        res << new(hash)
      end
      res
    end
    
    def clear
      open('w'){}
    end
    
    def append(line)
      open {|f| f.puts line}
    end
    
  protected
    def open(mode = 'a+', &block)
      File.open('/tmp/blog.csv', mode,&block)
    end
    
    def each_line(&block)
      open('r+') {|f| f.each_line &block}
    end
  end
  
  def initialize(attributes = {})
    @attributes = attributes
  end
  
  def title
    @attributes[:title]
  end
  
  def save
    self.class.append COLUMNS.map{|column| @attributes[column]}.join(';')
  end
end