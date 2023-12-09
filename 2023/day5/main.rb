require_relative 'lib/almanac'
require_relative 'lib/resource_mappings'

def parse_file(file_path)
  almanac = Almanac.new
  new_resource_map = nil

  File.foreach(file_path) do |line|
    next if line.strip.empty?

    case line
    when /^seeds: /
      seeds = line.scan(/\d+/).map(&:to_i)
      almanac.set_seeds(seeds)
    when /^[A-Za-z]/
      almanac.add_resource_mapping(new_resource_map) if new_resource_map

      words = line.split(/[- ]+/)
      source = words[0]
      destination = words[2]

      new_resource_map = ResourceMappings.new(destination, source)
    else
      destination_start, source_start, length = line.split.map(&:to_i)
      new_resource_map&.add_mapping(destination_start, source_start, length)
    end
  end
  almanac.add_resource_mapping(new_resource_map) if new_resource_map

  almanac
end

def get_location_number(almanac, seed)
  almanac.resource_mappings.each do |current_mapping|
    current_mapping.mappings.each do |mapping|
      if mapping.map_start <= seed && seed < mapping.map_end
        seed += mapping.map_offset
        break
      end
    end
  end

  seed
end
def get_lowest_location_number(almanac)
  lowest_location = nil
  seeds = almanac.seeds

  seeds.each_slice(2) do |start, count|
    puts "My current seed is #{start}"
    puts "My current count is #{count}"

    count.times do |i|
      puts "My current seed is #{start}, with count #{i}/#{count}" if (i % 1_000_000).zero?
      location_number = get_location_number(almanac, start)
      lowest_location = location_number if lowest_location.nil? || (location_number < lowest_location)
      start += 1
    end
  end

  lowest_location
end


almanac = parse_file('day5/data/lib.txt')
puts "Almanac seeds = #{almanac.seeds}"
lowest_location = get_lowest_location_number(almanac)
puts "The Lowest Location is #{lowest_location}"


