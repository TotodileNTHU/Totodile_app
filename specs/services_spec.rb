# frozen_string_literal: true

require_relative './spec_helper'
require 'webmock/minitest'

describe 'Test Service Objects' do
  before do
    WebMock.stub_request(:post, "#{API_URL}/accounts/authenticate")
           .with(body: HAPPY_CREDENTIAL.to_json)
           .to_return(body: HAPPY_ACCOUNT1.to_json,
                      headers: { 'content-type' => 'application/json' })

    WebMock.stub_request(:post, "#{API_URL}/accounts/authenticate")
           .with(body: SAD_CREDENTIAL.to_json)
           .to_return(status: 403)
  end

  describe 'Find authenticated account' do
    it 'HAPPY: should find an authenticated account' do
      result = FindAuthenticatedAccount.call(HAPPY_CREDENTIAL1.to_json).value
      
      result.wont_be_nil
      result['uid'].must_equal HAPPY_USERNAME1
      result['email'].must_equal HAPPY_EMAIL1
      
    end

    it 'BAD: should not find a false authenticated account' do
      result = FindAuthenticatedAccount.call(SAD_CREDENTIAL1.to_json)
      
      result.value.message.must_include "Wrong username/password"
    end
  end
end
