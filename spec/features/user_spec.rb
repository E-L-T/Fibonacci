require 'rails_helper'

describe 'User', type: :feature do

  scenario 'create a user' do
    visit sign_up_path
    expect do
      fill_in :user_email, with: 'email@test.com'
      fill_in :user_password, with: 'password_operateur'
      click_on 'Sign up'
    end.to change { User.count }.by(+1)

    expect(current_path).to eq edit_user_path User.last
    expect(User.last).to have_state(:submitted)
    expect(User.last).to transition_from(:submitted).to(:completed).on_event(:complete)

    fill_in :user_pdl, with: 'Point central'
    click_on 'Update User'

    expect(User.last).to have_state(:completed)
    expect(current_path).to eq '/'
  end

  scenario 'create a user with a go back' do
    visit sign_up_path
    expect do
      fill_in :user_email, with: 'email@test.com'
      fill_in :user_password, with: 'password_operateur'
      click_on 'Sign up'
    end.to change { User.count }.by(+1)

    expect(current_path).to eq edit_user_path User.last
    expect(User.last).to have_state(:submitted)
    expect(User.last).to transition_from(:submitted).to(:completed).on_event(:complete)
    click_on 'Go back'
    fill_in :user_email, with: 'email@test.fr'
    fill_in :user_password, with: 'password_secret'
    click_on 'Update User'

    fill_in :user_pdl, with: 'Point central'
    click_on 'Update User'
    expect(User.last).to have_state(:completed)
    expect(User.last.email).to eq 'email@test.fr'
    expect(current_path).to eq '/'
  end
end
