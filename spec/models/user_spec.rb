require 'rails_helper'

describe User do
  it { should have_one(:api_key) }
end
