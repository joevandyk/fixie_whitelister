require 'white_list_helper'

ActionController::Base.class_eval "include WhiteListHelper"
ActionController::Base.class_eval "before_filter :strip_naughty_stuff_from_form"
