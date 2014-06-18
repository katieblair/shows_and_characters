require 'rails_helper'

feature "user deletes a character", %Q{
As a site visitor
I want to delete a character I don't like
So no one else will want to watch that character
} do

# Acceptance Criteria:
# * I can delete a character from the database
# * If the record is not successfully deleted, I receive an error message

  scenario "user deletes a character" do

    television_show = TelevisionShow.create(title: 'Game of Thrones', network: 'HBO')

    character = Character.create(name: 'Arya Stark', actor: 'Maisie Williams', description: 'A badass little girl.', television_show: television_show)

    visit "/television_shows/#{television_show.id}"

    click_button 'Delete Character'

    expect(page).to have_content('Success!')
    expect(page).to_not have_content('Arya Stark')
    expect(page).to_not have_content('Maisie Williams')

  end


end
