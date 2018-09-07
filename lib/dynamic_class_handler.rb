require 'csv'

class DynamicClassHandler
  attr_reader :dynamic_class, :object_array
  def initialize(class_name)
    @dynamic_class = Object.const_set(class_name.capitalize, Class.new)
    @object_array = []
  end

  def create_attributes(user_attributes)
    dynamic_class.define_method('initialize') do |arguments|
      user_attributes.zip(arguments).each do |attribute, argument|
        instance_variable_set("@" + attribute.strip, argument)
      end
    end
    create_methods(user_attributes)
  end

  def create_methods(user_attributes)
    dynamic_class.define_method('to_s') do
      output_string = ""
      user_attributes.each do |attribute|
        output_string << "#{attribute} = #{instance_variable_get("@#{attribute}")}\n"
      end
      output_string
    end
  end

  def add_object(*arguments)
    object = dynamic_class.new(arguments)
    object_array << object
  end
end
