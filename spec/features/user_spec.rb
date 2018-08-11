require 'rails_helper'

describe 'User', type: :feature do

  scenario 'create a user with a go back' do
    visit sign_up_path
    expect do
      fill_in :user_email, with: 'henri@andre.com'
      fill_in :user_password, with: '1234!'
      fill_in :user_first_name, with: 'Henri'
      fill_in :user_last_name, with: 'André'
      fill_in :user_street_number, with: '1 ter'
      fill_in :user_street_name, with: 'Grande rue'
      fill_in :user_zip_code, with: '60210'
      fill_in :user_city, with: 'Sérifontaine'
      click_on 'Go to next step'
    end.to change { User.count }.by(+1)

    expect(current_path).to eq edit_user_path User.last
    expect(User.last).to have_state(:half_completed)
    expect(User.last).to transition_from(:half_completed).to(:completed).on_event(:complete)
    click_on 'Go back'
    fill_in :user_email, with: 'email@test.fr'
    fill_in :user_password, with: 'password_secret'
    click_on 'Go to next step'

    fill_in :user_pdl, with: 'Point central'
    choose :user_situation_move_in
    click_on 'Submit'
    expect(User.last).to have_state(:completed)
    expect(User.last.email).to eq 'email@test.fr'
    expect(current_path).to eq '/'
  end
end
