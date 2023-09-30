require 'rails_helper'

RSpec.feature 'Food Index', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'User views the list of available foods' do
    visit foods_path
  end

  scenario 'User views a message when there are no available foods' do
    visit foods_path

    expect(page).not_to have_table('food-table')
  end
end
