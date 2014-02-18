require 'spec_helper'

describe ContextHubVault do
  it 'should have a version number' do
    ContextHubVault::VERSION.should_not be_nil
  end

  it 'should be able to set its attributes via a configuration block' do
    ContextHubVault.configure do |config|
      config.host       = 'example.com'
      config.auth_token = 'qwertyasdfqwerty'
      config.version    = 42
      config.app_id     = 50
    end

    expect(ContextHubVault.host).to       eq('example.com')
    expect(ContextHubVault.app_id).to     eq(50)
    expect(ContextHubVault.auth_token).to eq('qwertyasdfqwerty')
    expect(ContextHubVault.version).to     eq(42)
  end
end
