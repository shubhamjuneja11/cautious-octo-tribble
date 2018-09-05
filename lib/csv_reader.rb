require_relative 'dynamic_class_handler'
class CsvReader
  def self.read(file_name)
    class_name = File.basename(file_name, '.*')
    handler = DynamicClassHandler.new(class_name)
    attributes, *objects_data = CSV.read(file_name)
    handler.create_attributes(attributes)
    objects_data.each do |object_array|
      handler.add_object(*object_array)
    end
    handler.object_array.each do|object|
      puts "#{object}\n"
    end
  end
end
