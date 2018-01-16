# == Schema Information
#
# Table name: quotes
#
#  id         :integer          not null, primary key
#  text       :string
#  author     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
