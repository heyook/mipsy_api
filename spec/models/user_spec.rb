require 'rails_helper'

describe User do
  it { should have_one(:api_key) }
  it { should have_many(:identities) }
end
