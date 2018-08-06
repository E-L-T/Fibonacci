require 'rails_helper'

describe 'User', type: :feature do
  scenario 'create an user (first step of the form)' do
    visit sign_up_path
    expect do
      fill_in :user_email, with: 'email@test.com'
      fill_in :user_password, with: 'password_operateur'
      click_on 'Sign up'
    end.to change { User.count }.by(+1)

    expect(User.last.state).to eq 'submitted'
    expect(current_path).to eq edit_user_path User.last
  end

  scenario 'edit an user (second step of the form)' do
    visit sign_up_path
    fill_in :user_email, with: 'email@test.com'
    fill_in :user_password, with: 'password_operateur'
    click_on 'Sign up'
    fill_in :user_pdl, with: 'Point central'
    click_on 'Update User'

    expect(User.last.state).to eq 'completed'
    expect(current_path).to eq '/'
  end
end
