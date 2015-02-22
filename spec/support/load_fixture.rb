module LoadFixture
  def fixture_file(filename)
    File.join(fixture_path, filename)
  end

  def load_fixture(filename)
    File.open fixture_file(filename)
  end
end

RSpec.configure do |config|
  config.include LoadFixture
end
