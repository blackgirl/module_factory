module Factory
  def new(*args, &block)
    args.each do |arg|
      define_method("#{arg}=") do |value|
        puts "@#{arg} was set to #{value}"
        instance_variable_set("@#{arg}",value)
      end
      define_method("#{arg}") do
        puts "Get @#{arg}"
        instance_variable_get("@#{arg}")
      end
      define_method("#{arg}?") do
        puts "If @#{arg}"
        send(arg) ? true : false
      end
    end
    class_eval &block
    self
  end
end

class Class
  extend Factory
end

myClass = Class.new :foo, :bar do
  puts 'my block eval'
end

myClass.foo = 9
myClass.bar = 6
puts myClass.bar
puts myClass.foo?

myClass1 = Class.new :foo1, :bar1 do
  puts 'my block eval one more time'
end

myClass1.foo1 = 91
myClass1.bar1 = 65
puts myClass1.bar1
puts myClass1.bar1?

puts myClass.class == myClass1.class