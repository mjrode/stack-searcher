# == Schema Information
#
# Table name: repos
#
#  id          :integer          not null, primary key
#  name        :string
#  external_id :integer
#  description :string
#  url         :string
#  stars       :integer
#  forks       :integer
#  score       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RepoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
