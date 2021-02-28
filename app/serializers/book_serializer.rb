class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author
  def author
    {auther_id: self.object.author.id,
    author_name: "#{self.object.author.first_name} #{self.object.author.last_name}"
    } 
  end
end
