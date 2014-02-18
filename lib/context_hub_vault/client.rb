require 'httparty'

module ContextHubVault
  class Client
    include HTTParty

    def initialize(host: ContextHubVault.host, auth_token: ContextHubVault.auth_token, version: ContextHubVault.version, app_id: ContextHubVault.app_id)
      if http_prefix(host)
        self.class.base_uri "#{host}/api"
      else
        self.class.base_uri "https://#{host}/api"
      end
      self.class.headers('Authorization' => %Q[Token token="#{auth_token}"]) if auth_token
      self.class.headers('Accept' => "application/vnd.carbon.vault.v#{version}") if version
      self.class.headers('HTTP_CARBON_APP_ID' => app_id) if app_id
    end

    private

    def http_prefix(host)
      host.downcase.start_with?('http://', 'https://')
    end
  end
end
