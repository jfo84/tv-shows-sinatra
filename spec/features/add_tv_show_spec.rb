require "spec_helper"

# As a TV fanatic
# I want to add one of my favorite shows
# So that I can encourage others to binge watch it
#
# Acceptance Criteria:
# * I must provide the title, network, and starting year.
# * I can optionally provide the final year, genre, and synopsis.
# * The synopsis can be no longer than 5000 characters.
# * The starting year and ending year (if provided) must be
#   greater than 1900.
# * The genre must be one of the following: Action, Mystery,
#   Drama, Comedy, Fantasy
# * If any of the above validations fail, the form should be
#   re-displayed with the failing validation message.

feature "user adds a new TV show" do

  scenario "successfully add a new show" do

    visit '/'

    click_link('Add New Show')
    fill_in 'title', with: 'Californication'
    fill_in 'network', with: 'Showtime'
    fill_in 'starting_year', with: '2007'
    fill_in 'ending_year', with: '2014'
    select("Drama", :from => "Genre")
    fill_in 'synopsis', with: 'Story of a writer with a child and lover'

    click_button 'Add TV Show'

    expect(page).to have_content('Californication (Showtime)')

  end

  scenario "fail to add a show without title" do

    visit '/'

    click_link('Add New Show')
    fill_in 'network', with: 'Showtime'
    fill_in 'starting_year', with: '2007'
    fill_in 'ending_year', with: '2014'
    select("Drama", :from => "Genre")
    fill_in 'synopsis', with: 'Story of a writer with a child and lover'

    click_button 'Add TV Show'

    expect(page).to have_content('Add Show')
  end

  scenario "fail to add a show with a synopsis that is too long" do

    visit '/'

    synopsis = 1..10_000

    click_link('Add New Show')
    fill_in 'network', with: 'Showtime'
    fill_in 'starting_year', with: '2007'
    fill_in 'ending_year', with: '2014'
    select("Drama", :from => "Genre")
    fill_in 'synopsis', with: "#{synopsis}"

    click_button 'Add TV Show'

    expect(page).to have_content('Add Show')
  end

end
