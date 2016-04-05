require 'test_helper'
require 'generators/sub/sub_generator'

module Sub
  class SubGeneratorTest < Rails::Generators::TestCase
    tests SubGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
