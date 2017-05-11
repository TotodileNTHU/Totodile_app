# frozen_string_literal: true

folders = 'config,services,controllers,values'
Dir.glob("./{#{folders}}/init.rb").each do |file|
  require file
end
