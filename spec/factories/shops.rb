# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    sequence :name do |n|
      "商家名稱_#{n}"
    end
    email { 'river@riverye.com' }
    note { 'test' }
  end
end
