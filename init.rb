require 'white_list_helper'


module WhiteListHelper

  protected

  def strip_naughty_stuff_from_form
    strip_naughty_stuff_from_hash(params)
  end

  def strip_naughty_stuff_from_hash hsh
    return unless hsh.respond_to?(:each_pair)
    hsh.each_pair do |key, value|
      if value.class == String
        hsh[key] = white_list(value)
      elsif value.respond_to?(:[])
        strip_naughty_stuff_from_hash(value)
      end
    end
  end
end

ActionController::Base.class_eval "include WhiteListHelper"
ActionController::Base.class_eval "before_filter :strip_naughty_stuff_from_form"
