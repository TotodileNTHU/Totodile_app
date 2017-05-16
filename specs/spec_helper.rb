# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'

require './init.rb'

def app
  TotodileApp
end

API_URL = app.config['API_URL'].freeze

HAPPY_USERNAME1 = 'fb_uid_1'
HAPPY_PASSWORD1 = '1234'
HAPPY_EMAIL1 = 'cory@gmail.com'
HAPPY_NAME1 = 'cory'
HAPPY_CREDENTIAL = { uid: HAPPY_USERNAME1, password: HAPPY_PASSWORD1 }
HAPPY_CREDENTIAL1 = { username: HAPPY_USERNAME1, password: HAPPY_PASSWORD1 }
HAPPY_ACCOUNT1 = {"type"=>"account", "uid"=>HAPPY_USERNAME1, "email"=>HAPPY_EMAIL1, "name"=>HAPPY_NAME1}

SAD_PASSWORD1 = 'qmdfoert324)'
SAD_CREDENTIAL = { uid: HAPPY_USERNAME1, password: SAD_PASSWORD1 }
SAD_CREDENTIAL1 = { username: HAPPY_USERNAME1, password: SAD_PASSWORD1 }
