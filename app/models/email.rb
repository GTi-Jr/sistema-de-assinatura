class Email < ActiveRecord::Base
  enum to: { everyone: 0, signing_users: 1, unsigning_users: 2  }
end
