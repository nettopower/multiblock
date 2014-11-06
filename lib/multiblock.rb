require "multiblock/version"

module Multiblock
  if defined?(BasicObject)
    BasicObject = ::BasicObject
  elsif defined?(BlankSlate)
    BasicObject = ::BlankSlate
  else

    # If neither BasicObject (Ruby 1.9) nor BlankSlate (typically provided by Builder)
    # are present, define our simple implementation
    class BasicObject
      instance_methods.each do |meth|
        unless meth =~ /\A__/ || %w[ instance_exec instance_eval == equal? object_id ! != ].include?(meth)
          undef_method(meth)
        end
      end
    end
  end

  class << self
    def wrapper(*args, &blk)
      Wrapper.new(*args, &blk)
    end

    def wrap(defaults=::Kernel.lambda { |*args| nil }, &blk)
      wrapper = Wrapper.new(&defaults)
      yield(wrapper)
      wrapper
    end
  end
end

require "multiblock/wrapper"
