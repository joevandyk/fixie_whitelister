module WhiteListHelper
  def self.included klass
    klass.class_eval do
      include InstanceMethods
      extend  ClassMethods
    end
  end

  module ClassMethods
    def sanitizer
      @sanitizer ||= HTML::WhiteListSanitizer.new
    end
  end

  module InstanceMethods 
    def strip_naughty_stuff_from_form
      strip_naughty_stuff(params)
    end

    def strip_naughty_stuff input
      case input
      when Hash
        input.each_pair do |key, value|
          input[key] = strip_naughty_stuff(value)
        end
      when String
        self.class.sanitizer.sanitize(input)
      when Array
        input.map { |i| strip_naughty_stuff(i) }
      else
        raise "WHAT ARE YOU? '#{input.inspect}'"
      end
    end
  end
end
