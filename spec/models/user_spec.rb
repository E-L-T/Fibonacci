require 'rails_helper'

describe User, type: :model do
  context 'In form first step' do
    before { subject.state = :submitted }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :street_number }
    it { should validate_presence_of :street_name }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :city }
  end

  context 'In form second step' do
    before { subject.state = :completed }
    it { should validate_presence_of :pdl }
    it { should validate_presence_of :situation }
  end
end
