require 'fiddle'
require 'pry'

User = Struct.new :name

class NullUser < NilClass
  def self.new(*args, &block)
    obj           = Object.new
    # this gets one pointer for the address at 2x the object_id integer of the obj we made
    obj_ptr       = Fiddle::Pointer.new 2*obj.object_id
    # this gets one pointer for the address at 2x the object_id integer of this object
    klass_ptr     = Fiddle::Pointer.new 2*self.object_id
    # we set the objects  pointer address to be the neww point of this classes spot, overwriting
    # where it keeps nil and false
    obj_ptr[8, 8] = klass_ptr.ref[0, 8]
    # return our maniuplated thing
    obj
  end

  # give our null user   method
  def name
    ''
  end
end

# a real user!
user = User.new "Bob"  # => #<struct User name="Bob">

puts user.name                   # => "Bob"
puts user.to_h                   # => {:name=>"Bob"}


puts user = NullUser.new  # => nil
puts user.name            # => ""
puts user.to_h            # => {}

if user
  # spoiler, we hit this even though user is nil
  puts "User exists"
else
  # never get here lol
  puts "User aint real"
end
a = []
10000.times do |t| Thread.new { |_| a << NullUser.new } end
# lets look cuz wtf right?
# it says user exists but user is friggin nil

binding.pry
puts "done"
