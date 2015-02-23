require 'rails_helper'

RSpec.describe Repost, type: :model do
  it { should belong_to(:article) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:ref_id) }
  it { should validate_presence_of(:ref_type) }
end
