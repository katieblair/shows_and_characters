require 'rails_helper'

feature 'user views a list of characters', %Q{
  As a site visitor
  I want to view a list of people's favorite TV characters
  So I can find wonky characters to watch
} do

  # Acceptance Criteria:
  # * I can see a list of all the characters
  # * The character's name and the TV show it is associated with are listed

  scenario 'user views all characters' do
    show1 = TelevisionShow.create!(title: 'Game of Thrones', network: 'HBO')
    show2 = TelevisionShow.create!(title: 'Orphan Black', network: 'BBC America')
    characters = []
    character_attrs = [
      { name: 'Arya Stark', actor: 'Maisie Williams', television_show_id: show1.id },
      { name: 'Alison Hendrix', actor: 'Tatiana Maslany', television_show_id: show2.id }
    ]

    character_attrs.each do |attrs|
      characters << Character.create(attrs)
    end


    visit "/characters"

    expect(page).to have_content('Arya Stark')
    expect(page).to have_content('Maisie Williams')
    expect(page).to have_content('Game of Thrones')
    expect(page).to have_content('Alison Hendrix')
    expect(page).to have_content('Tatiana Maslany')
    expect(page).to have_content('Orphan Black')

  end

end
