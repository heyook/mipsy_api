require 'rails_helper'

describe ApiKey do
  it { should belong_to(:token_authenticatable) }
end
