FactoryGirl.define do
  factory :localized_page do
    title "MyString"
content "MyText"
slug "MyString"
language nil
page nil
  end

end

# == Schema Information
#
# Table name: localized_pages
#
#  id          :integer          not null, primary key
#  language_id :integer
#  page_id     :integer
#  title       :string(255)
#  content     :text(65535)
#  slug        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_localized_pages_on_language_id  (language_id)
#  index_localized_pages_on_page_id      (page_id)
#