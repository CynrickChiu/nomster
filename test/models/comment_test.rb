require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "humanized_rating" do
    comment = FactoryGirl.create(:comment, :rating => '1_star')
    assert_equal 'one star', comment.humanized_rating
  end
end
