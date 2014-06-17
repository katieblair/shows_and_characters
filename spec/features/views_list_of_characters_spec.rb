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
      { name: 'Arya Stark', actor: 'Maisie Williams', television_show_id: 1 },
      { name: 'Alison Hendrix', actor: 'Tatiana Maslany', television_show_id: 2 }
    ]

    character_attrs.each do |attrs|
      characters << Character.create(attrs)
    end


    visit "/characters"
    characters.each do |character|
      expect(page).to have_content character.name
      expect(page).to have_content television_show.network
    end

  end



end
