class Mapping
  attr_reader :map_start, :map_end, :map_offset

  def initialize(map_start, map_end, map_offset)
    @map_start = map_start
    @map_end = map_end
    @map_offset = map_offset
  end
end
