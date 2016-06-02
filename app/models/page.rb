class Page < ActiveRecord::Base
  extend FriendlyId
  include Resource

  PUBLIC_FIELDS = [:title]

  has_many :localized_pages, dependent: :destroy

  friendly_id :title, use: :slugged

  accepts_nested_attributes_for :localized_pages

  validates :title, presence: true, uniqueness: true

  class << self
    def first?(id)
      id == Page.order('created_at ASC').pluck(:id).first
    end

    def home
      Page.order('created_at ASC').first
    end
  end

  def resource_title
    self.title
  end
end

# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  slug       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
