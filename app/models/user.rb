class User < ApplicationRecord
  include AASM
  include Clearance::User
  validates_presence_of :email, :password, :first_name, :last_name, :street_number, :street_name, :zip_code, :city, if: -> { state == 'submitted' }
  validates_presence_of :pdl, :situation, if: -> { state == 'completed' }
  enum situation: [ :move_in, :new_house, :temporary_access ]

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

    event :back_to_submitted do
      transitions from: :completed, to: :submitted
    end

    event :back_to_undefined do
      transitions from: :submitted, to: :undefined
    end
  end
end
