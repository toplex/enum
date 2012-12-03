require 'enum_value'

class Enum
  attr_reader :klass, :name, :by_name, :by_value
  
  def initialize(name, klass=nil, hash={})
    klass, hash = nil, klass if klass.is_a?(Hash)
    @name, @klass = name, klass
    map_hash(hash)
    generate_methods
  end

  def to_s
    @klass ? "#{@klass.name}::#{@name}" : @name.to_s
  end
  def inspect
    "#{to_s}(#{@by_name.map { |n,ev| "#{n.inspect} => #{ev.value.inspect}"}.join(", ")})"
  end

  def names
    @by_name.keys
  end
  def values
    @by_value.keys
  end

  def [](name_or_value)
    ev = @by_name[name_or_value] || @by_value[name_or_value]
    raise "#{inspect} does not know #{name_or_value.inspect}" if ev.nil?
    ev
  end

  private
  def map_hash(hash)
    @by_name = {}
    @by_value = {}
    hash.each do |n, v|
      n, v = v, n if v.is_a?(Symbol) or n.is_a?(Numeric)
      raise "duplicate enum name #{n} for #{to_s}" if @by_name.has_key?(n)
      raise "duplicate enum value #{v} for #{to_s}.#{n}" if @by_value.has_key?(v)
      raise "value can't be nil for #{to_s}.#{n}" if v.nil?
      @by_name[n] = @by_value[v] = EnumValue.new(self, n, v)
    end
  end
  def generate_methods
    names.each do |name|
      define_singleton_method(name) { self[name] }
    end
  end
end

require 'helpers'
