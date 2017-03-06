require 'opal'
require 'react/react-source' #-browser'
require 'hyper-react'
require 'hyper-store'
#require 'hyper-component'
#require 'hyper-store'
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser/delay'
end
require_tree './components'
