require 'capybara'
require 'pry'
begin; require 'turn/autorun'; rescue LoadError; end
Turn.config.format = :dot

class CapybaraTestCase < MiniTest::Unit::TestCase
  include Capybara::DSL
  def setup
    Capybara.current_driver = :selenium
  end

  def get_js(code)
    page.execute_script("return #{code}")
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end