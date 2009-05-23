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
      strip_naughty_stuff_from_hash(params)
    end

    def strip_naughty_stuff_from_hash hsh
      return unless hsh.respond_to?(:each_pair)
      hsh.each_pair do |key, value|
        if value.class == String
          hsh[key] = self.class.sanitizer.sanitize(value)
        elsif value.respond_to?(:[])
          strip_naughty_stuff_from_hash(value)
        end
      end
    end
  end
end

