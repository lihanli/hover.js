require 'test_helper'

class HoverTest < CapybaraTestCase
  def setup
    super
    @test_url = "file://#{Dir.pwd}/test/test.html"
  end

  def test_hover
    visit @test_url
    page.execute_script("$('#img1').mousemove()")
    binding.pry
  end

end