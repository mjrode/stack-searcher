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

class Quote < ApplicationRecord

  def next_id
    self.class.where('id > ?', self.id).pluck(:id).first
  end

  def previous_id
    self.class.where('id < ?', self.id).pluck(:id).last
  end
end
