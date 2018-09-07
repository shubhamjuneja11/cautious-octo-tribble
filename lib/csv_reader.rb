require_relative 'dynamic_class_handler'
class CsvReader

  def create_objects_array(file_name)
    class_name = File.basename(file_name, '.*')
    handler = DynamicClassHandler.new(class_name)
    read(handler, file_name)
    print_array(handler)
  end

  def read(handler, file_name)
    attributes, *objects_data = CSV.read(file_name)
    create_objects(handler, attributes, objects_data)
  end

  private def create_objects(handler, attributes, objects_data)
    handler.create_attributes(attributes)
    objects_data.each do |object_array|
      handler.add_object(*object_array)
    end
  end

  private def print_array(handler)
    handler.object_array.each do|object|
      puts "#{object}\n"
    end
  end
end
