require 'spec_helper'

describe ContextHubVault::Client do
  context 'initialization' do
    let(:host)       { 'example.com' }
    let(:auth_token) { nil }
    let(:version)    { nil }
    let(:app_id)     { nil }
    let!(:client)    { ContextHubVault::Client.new(host: host, auth_token: auth_token, version: version, app_id: app_id) }

    context 'defaults' do
      it 'should default to ssl when given a hostname' do
        client.class.base_uri.should == 'https://example.com/api'
      end

      it 'should not have the authorization header set' do
        client.class.headers.should_not have_key('Authorization')
      end

      it 'should not have the version header set' do
        client.class.headers.should_not have_key('Accept')
      end
    end

    context 'custom' do
      let(:host) { 'http://example.com:5000' }
      let(:auth_token) { 'abcdef' }
      let(:version) { 42 }

      it 'should use http if explicitly defined' do
        client.class.base_uri.should == 'http://example.com:5000/api'
      end

      it 'should set the authorization header if given an auth token' do
        client.class.headers['Authorization'].should eq 'Token token="abcdef"'
      end

      it 'should set the version header if given a version' do
        client.class.headers['Accept'].should eq 'application/vnd.carbon.vault.v42'
      end
    end
  end
end
