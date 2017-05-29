# frozen_string_literal: true

require 'dry-validation'

NewPosting= Dry::Validation.Form do
  required(:content).filled

  configure do
    config.messages_file = File.join(__dir__, 'new_posting_errors.yml')
  end
end
