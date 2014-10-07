module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))#equivalent to self.username, self.title or self.name
    obj = self.class.find_by slug: the_slug 
    #self works with modules as when the modules are being called in the class, it is as if the istances are called within it through self.
    count = 2
    while obj && obj != self
      the_slug = append_suffix(the_slug, count)
      obj = self.class.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/,"-"
    str.downcase
  end

  module ClassMethods 
  # we are trying to expose a class method for the class included this module to set the column name to use, then we are saving the column name in an attribute that we can reference in our instances. 
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end

























