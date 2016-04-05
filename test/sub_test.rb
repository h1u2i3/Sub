require 'test_helper'

class Sub::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Sub
  end
end
