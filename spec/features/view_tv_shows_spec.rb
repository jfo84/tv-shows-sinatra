require "spec_helper"
require "pry"

feature "user views list of TV shows" do
  # As a TV fanatic
  # I want to view a list of TV shows
  # So I can find new shows to watch
  #
  # Acceptance Criteria:
  # * I can see the names and networks of all TV shows

  scenario "view list of TV shows" do
    # First create some sample TV shows
    game_of_thrones = TelevisionShow.create!({
        title: "Game of Thrones", network: "HBO",
        starting_year: 2011, genre: "Fantasy"
      })

    married_with_children = TelevisionShow.create!({
        title: "Married... with Children", network: "Fox",
        starting_year: 1987, ending_year: 1997,
        genre: "Comedy"
      })

    # The user visits the index page
    visit "/television_shows"

    # And should see both TV shows listed (just the title and network)
    expect(page).to have_content("Game of Thrones (HBO)")
    expect(page).to have_content("Married... with Children (Fox)")
  end

  # As a TV fanatic
  # I want to view the details for a TV show
  # So I can find learn more about it

  # Acceptance Criteria:
  # * I can see the title, network, start and end year, genre, and synopsis
  #   for a show.
  # * If the end year is not provided it should indicate that the show is still
  #   running.

  scenario "view details for a TV show" do

    game_of_thrones = TelevisionShow.create!({
        title: "Game of Thrones", network: "HBO",
        starting_year: 2011, genre: "Fantasy"
      })

    visit '/'

    click_link("Game of Thrones (HBO)")

    expect(page).to have_content("Game of Thrones")
    expect(page).to have_content("2011 -")
    expect(page).to have_content("Fantasy")

  end

  scenario "view details for a TV show with missing information" do

    silicon_valley = TelevisionShow.create!({
        title: "Silicon Valley", network: "HBO",
        starting_year: 2014, genre: "Comedy"
      })

    visit '/'

    click_link("Silicon Valley (HBO)")

    expect(page).to have_content("Silicon Valley")
    expect(page).to have_content("2014 -")
    expect(page).not_to have_content("Synopsis")

  end
end
