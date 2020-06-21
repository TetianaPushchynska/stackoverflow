# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many :answers }
  it { should have_many :attachments }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  describe 'reputation' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'should calculate reputation after creating' do
      expect(Reputation).to receive(:calculate).with(question)
      question.save!
    end

    it 'should not calculate reputation after update' do
      question.save!
      question.update(title: '1234')
      expect(Reputation).to_not receive(:calculate)
    end

    it 'should save user reputation' do
      allow(Reputation).to receive(:calculate).and_return(5)
      expect{question.save!}.to change(user, :reputation).by(5)
    end

    it 'test time' do
      now = Time.now.utc
      allow(Time).to receive(:now) { now }
      question.save!
      expect(question.created_at).to eq now
    end
  end
end
