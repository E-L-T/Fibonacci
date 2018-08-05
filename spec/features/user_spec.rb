require 'rails_helper'

describe 'User', type: :feature do
  scenario 'create an user' do
    visit sign_up_path
    expect do
      fill_in :user_email, with: 'email@test.com'
      fill_in :user_password, with: 'password_operateur'
      click_on 'Sign up'
    end.to change { User.count }.by(+1)
    expect(User.last.state).to eq 'submitted'
  end
end
