class User < ApplicationRecord
  include AASM
  include Clearance::User
  validates_presence_of :email, :password, :first_name, :last_name, :street_number, :street_name, :zip_code, :city, if: -> { state == 'half_completed' }
  validates_presence_of :pdl, :situation, if: -> { state == 'completed' }
  enum situation: [ :move_in, :new_house, :temporary_access ]

  aasm column: 'state' do
  end

  aasm do
    state :uncompleted, initial: true
    state :half_completed, :completed

    event :half_complete do
      transitions from: :uncompleted, to: :half_completed
    end

    event :complete do
      transitions from: :half_completed, to: :completed
    end

    event :back_to_half_completed do
      transitions from: :completed, to: :half_completed
    end

    event :back_to_uncompleted do
      transitions from: :half_completed, to: :uncompleted
    end
  end
end
