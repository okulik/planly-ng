class ApplicationController < ActionController::API
  # include ActionController::MimeResponds
  # include ActionController::ImplicitRender
  # include ActionController::RespondWith
  include DeviseTokenAuth::Concerns::SetUserByToken
end
