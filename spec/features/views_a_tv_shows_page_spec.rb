require 'rails_helper'

feature "user views a TV show's details", %Q{
  As a site visitor
  I want to view the details for a TV show
  So I can learn more about it
} do

  # Acceptance Criteria:
  # * I can see a the show's title, network, the years it ran,
  # and a synopsis
  # * For each character, I can see the character's name, actor's name, and the character's description

  scenario "user views a TV show's details" do
    show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO')

    visit "/television_shows/#{show.id}"

    expect(page).to have_content show.title
    expect(page).to have_content show.network
    expect(page).to have_content show.years
    expect(page).to have_content show.synopsis
  end

  scenario "user views a TV show's characters" do
    show = TelevisionShow.create!(title: 'Game of Thrones',
      network: 'HBO', years: "2011 -", synopsis: 'Seven noble families fight for control of the mythical land of Westeros.')
    character = Character.create!(name: 'Arya Stark', actor: 'Maisie Williams', description: 'A badass little girl.', television_show_id: show.id)

    visit "/television_shows/#{show.id}"

    expect(page).to have_content('Arya Stark')
    expect(page).to have_content('Maisie Williams')
    expect(page).to have_content('A badass little girl.')

  end

end
