require_relative 'mapping'

class ResourceMappings
  attr_reader :destination, :source, :mappings

  def initialize(destination, source)
    @destination = destination
    @source = source
    @mappings = []
  end

  def add_mapping(destination_start, source_start, length)
    @mappings << Mapping.new(source_start, source_start + length, destination_start - source_start)
  end
end
