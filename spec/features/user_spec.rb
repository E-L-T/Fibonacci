require 'rails_helper'

describe 'User', type: :feature do
  let(:half_completed_user) { create :user, state: 'half_completed' }

  scenario 'create a user' do
    visit sign_up_path
    expect do
      fill_in :user_email, with: 'john@bryan.com'
      fill_in :user_password, with: '1234!'
      fill_in :user_first_name, with: 'John'
      fill_in :user_last_name, with: 'Bryan'
      fill_in :user_street_number, with: '1 ter'
      fill_in :user_street_name, with: 'Grande rue'
      fill_in :user_zip_code, with: '60210'
      fill_in :user_city, with: 'Sérifontaine'
      click_on 'Go to next step'
    end.to change { User.count }.by(+1)

    expect(current_path).to eq edit_user_path User.last
    expect(User.last).to have_state(:half_completed)
    expect(User.last).to transition_from(:half_completed).to(:completed).on_event(:complete)

    fill_in :user_pdl, with: 'Point central'
    choose :user_situation_move_in
    click_on 'Submit'

    expect(User.last).to have_state(:completed)
    expect(User.last.email).to eq 'john@bryan.com'
    expect(current_path).to eq root_path
  end

  scenario 'can go back when filling the form' do
    visit edit_user_path half_completed_user
    expect(page).to have_content 'Technical informations'
    click_on 'Go back'
    expect(User.last).to have_state(:uncompleted)
    fill_in :user_email, with: 'john@gmail.com'
    fill_in :user_password, with: '12345!'
    click_on 'Go to next step'
    expect(User.last).to have_state(:half_completed)
    fill_in :user_pdl, with: 'Point alternatif'
    choose :user_situation_move_in
    click_on 'Submit'
    expect(User.last).to have_state(:completed)
    expect(User.last.email).to eq 'john@gmail.com'
    expect(current_path).to eq root_path
  end
end
