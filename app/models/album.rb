class Album < ApplicationRecord
    has_one_attached :cover_image
    has_many_attached :photos, dependent: :destroy 

    validates :cover_image, presence: true
    validates :photos, presence: true 
    validates :title, presence: true, length: { maximum: 255 }
    validates :description, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    
    has_many :taggings
    has_many :tags, through: :taggings

def all_tags=(names)

    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end
  
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.ransackable_associations(auth_object = nil)
    ["tags"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "price", "title", "updated_at"]
  end


end
