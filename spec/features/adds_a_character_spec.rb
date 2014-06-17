require 'rails_helper'

feature 'user adds a new character', %Q{
  As a site visitor
  I want to add my favorite TV show characters
  So that other people can enjoy their crazy antics
} do

  # Acceptance Criteria:
  # * I can access a form to add a character on a TV show's page
  # * I must specify the character's name and the actor's name
  # * I can optionally provide a description
  # * If I do not provide the required information, I receive an error message
  # * If the character already exists in the database, I receive an error message

  scenario 'user adds a new character' do

    television_show = TelevisionShow.create!(title: 'Game of Thrones', network: 'HBO')

    visit "/television_shows/#{television_show.id}"

    fill_in 'Name', with: 'Arya Stark'
    fill_in 'Actor', with: 'Maisie Williams'
    fill_in 'Description', with: 'A badass little girl.'

    click_button 'Create Character'

    expect(page).to have_content('Arya Stark')
    expect(page).to have_content('Maisie Williams')
    expect(page).to have_content('A badass little girl.')
    expect(page).to have_content('Success!')

  end

  scenario 'fails to save if missing attributes' do

    television_show = TelevisionShow.create!(title: 'Game of Thrones', network: 'HBO')

    visit "/television_shows/#{television_show.id}"

    click_button 'Create Character'

    expect(page).to have_content("Invalid answer!  Please make sure you have entered a unique character name and that you have entered an actor.")

    expect(Character.count).to eq(0)

  end

  scenario 'user cannot add a character who has already been added' do

    television_show = TelevisionShow.create!(title: 'Game of Thrones', network: 'HBO')
    character = Character.create!(name: 'Arya Stark', actor: 'Maisie Williams')

    visit "/television_shows/#{television_show.id}"
    fill_in 'Name', with: 'Arya Stark'
    fill_in 'Actor', with: 'Maisie Williams'
    click_button 'Create Character'

    expect(page).to_not have_content('Success!')
    expect(page).to have_content("Invalid answer!  Please make sure you have entered a unique character name and that you have entered an actor.")

  end


end
