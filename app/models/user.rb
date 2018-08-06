class User < ApplicationRecord
  include AASM
  include Clearance::User
  validates_presence_of :email, :password, if: -> { state == 'submitted' }
  validates_presence_of :pdl, if: -> { state == 'completed' }
  aasm column: 'state' do
  end

  aasm do
    state :undefined, initial: true
    state :submitted, :completed

    event :submit do
      transitions from: :undefined, to: :submitted
    end

    event :complete do
      transitions from: :submitted, to: :completed
    end

    event :undefine do
      transitions from: :submitted, to: :undefined
    end
  end
end
