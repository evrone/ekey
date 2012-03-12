require "ekey/version"
require "ekey/certificate"

module Ekey
  module Config
    # API_KEY for cabinet.ekey.ru.
    mattr_accessor :api_key
  end
end
