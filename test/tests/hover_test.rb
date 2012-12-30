require 'test_helper'

class HoverTest < CapybaraTestCase
  def setup
    super
    @test_url        = "file://#{Dir.pwd}/test/test.html"
    @hover_img_class = '.hover-image'
  end

  def hover_img(sel)
    %w(mouseenter mousemove).each do |action|
      page.execute_script("$('#{sel}').#{action}()")
    end
  end

  def num_visible_imgs
    get_js "$('#{@hover_img_class}:visible').length"
  end

  def get_hover_img_src
    get_js "$('#{@hover_img_class}:visible img').attr('src')"
  end

  def unhover(sel)
    page.execute_script "$('#{sel}').mouseleave()"
  end

  def test_hover
    visit @test_url
    assert_equal 0, num_visible_imgs

    %w(fish yosemite).each do |img|
      hover_img "##{img}"
      assert_equal "#{img}.jpg", get_hover_img_src

      unhover "##{img}"
      assert_equal 0, num_visible_imgs
    end

  end

end