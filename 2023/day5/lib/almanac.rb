class Almanac
  attr_reader :seeds, :resource_mappings

  def initialize
    @seeds = []
    @resource_mappings = []
  end

  def set_seeds(new_seeds)
    @seeds = new_seeds
  end

  def add_resource_mapping(resource_mapping)
    puts "resource_mapping = #{resource_mapping}"
    puts "@resource_mappings = #{@resource_mappings}"
    @resource_mappings << resource_mapping
  end
end
