class User < ApplicationRecord
  include Sub::Concerns::UploaderAttribute

  upload_for :avatar
end
