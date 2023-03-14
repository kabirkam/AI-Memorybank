require "test_helper"

class SentencesControllerTest < ActionDispatch::IntegrationTest
  test "should get like_sentence" do
    get sentences_like_sentence_url
    assert_response :success
  end
end
