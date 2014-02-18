require 'context_hub_vault/version'

module ContextHubVault
  class << self
    attr_accessor :host, :version, :auth_token, :app_id

    # config/initializers/context_hub_vault.rb (for instance)
    #
    # ContextHubVault.configure do |config|
    #   config.host       = 'example.com'
    #   config.auth_token = 'qwertyasdfqwerty'
    #   config.version    = 42
    #   config.app_id     = 50
    # end
    #
    # elsewhere
    #
    # client = ContextHubVault::Client.new
    def configure
      yield self
      true
    end
  end
end
