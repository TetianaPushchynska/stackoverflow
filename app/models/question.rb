# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable
  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
