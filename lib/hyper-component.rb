require "hyperloop/component/version"
require 'hyperloop-config'
Hyperloop.import 'hyper-component'
if RUBY_ENGINE == 'opal'
  module Hyperloop
    class Component
      # defining this before requring hyper-react will turn
      # off the hyper-react deprecation notice
    end
  end
  require 'hyper-react'
  module React
    module Component
      class Base
        def self.inherited(child)
          debugger
          # note this is turned off during old style testing:  See the spec_helper
          unless child.to_s == "React::Component::HyperTestDummy"
            React::Component.deprecation_warning child, "The class name React::Component::Base has been deprecated.  Use Hyperloop::Component instead."
          end
          child.include(ComponentNoNotice)
        end
      end
    end
  end
else
  require 'opal'
  require 'react-rails'
  require 'opal-rails'
  require 'hyper-react'
  Opal.append_path(File.expand_path('../', __FILE__).untaint)
end
