require "hyperloop/component/version"
if RUBY_ENGINE != 'opal'
  module Hyperloop
    class Component
      # defining this before requring hyper-react will turn
      # the hyper-react deprecation notice
    end
  end
  require 'hyper-react'
else
  require 'opal'
  require 'hyper-react'
  Opal.append_path(File.expand_path('../', __FILE__).untaint)
end
