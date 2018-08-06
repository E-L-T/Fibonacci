require 'rails_helper'

describe User, type: :model do
  context 'In form first step' do
    before { subject.state = :submitted }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  context 'In form second step' do
    before { subject.state = :completed }
    it { should validate_presence_of :pdl }
  end
end
