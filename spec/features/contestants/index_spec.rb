require 'rails_helper'

RSpec.describe Contestant do
  before(:each) do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
  end

  it 'has contestant names' do

    visit "/contestants"
  
    expect(page).to have_content("#{@jay.name}")
    expect(page).to have_content("#{@gretchen.name}")
    expect(page).to have_content("#{@kentaro.name}")
    expect(page).to have_content("#{@erin.name}")
  end

  it 'has list of all associated projects names' do
    @news_chic.contestants << @kentaro
    @lit_fit.contestants << @kentaro

    @news_chic.contestants << @gretchen

    @lit_fit.contestants << @jay

    visit "/contestants"

    expect(page).to have_content("Projects: Litfit")
    expect(page).to have_content("Projects: News Chic")
    expect(page).to have_content("Projects: News Chic Litfit")
  end
end