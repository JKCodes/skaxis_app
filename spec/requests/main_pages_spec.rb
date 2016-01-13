require 'rails_helper'

RSpec.describe "MainPages", type: :request do

  let(:basic_title) { "Skaxis -" }

  describe "Home page" do
  
    it "should have 'Skaxis'" do
      visit '/main_pages/home'
      expect(page).to have_content('Skaxis')
    end

    it "should have the title 'Home'" do
      visit '/main_pages/home'
      expect(page).to have_title("#{basic_title} Home")
    end
  end

  describe "Help page" do

    it "should have 'Help'" do
      visit '/main_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit '/main_pages/help'
      expect(page).to have_title("#{basic_title} Help")
    end
  end

  describe "About page" do
   
    it "should have 'About Me'" do
      visit '/main_pages/about'
      expect(page).to have_content('About Me')
    end
    it "should have the title 'About Me'" do
      visit '/main_pages/about'
      expect(page).to have_title("#{basic_title} About Me")
    end 
  end
end
