require "pagy_mongoid_cursor/pagy/extras/cursor"
require 'pagy/extras/overflow'
require 'pagy/extras/bootstrap'

Pagy::DEFAULT[:items] = 9

Pagy::DEFAULT[:overflow] = :last_page
