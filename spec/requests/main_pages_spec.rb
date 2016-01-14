require 'rails_helper'
require 'support/utilities.rb'

RSpec.describe "MainPages", type: :request do

  subject { page }

  shared_examples "all main pages" do
    it { is_expected.to have_selector('h1', text: heading) }
    it { is_expected.to have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading)    { 'Skaxis' }
    let(:page_title) { '' }

    it_behaves_like "all main pages"
    it { is_expected.not_to have_title('Skaxis - Home') }
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_behaves_like "all main pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading)    { 'About' }
    let(:page_title) { 'About Me' }

    it_behaves_like "all main pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_behaves_like "all main pages"
  end
  
  describe "Terms page" do
    before { visit terms_path }

    let(:heading)    { 'Terms' }
    let(:page_title) { 'Terms' }

    it_behaves_like "all main pages"
  end

  describe "Privacy page" do
    before { visit privacy_path }

    let(:heading)    { 'Privacy' }
    let(:page_title) { 'Privacy' }

    it_behaves_like "all main pages"
  end

  it "should have correct links on layouts" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Me'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Terms"
    expect(page).to have_title(full_title('Terms'))
    click_link "Privacy"
    expect(page).to have_title(full_title('Privacy'))
    click_link "Home"
    expect(page).to have_title(full_title(''))
    click_link "Skaxis"
    expect(page).to have_title(full_title(''))
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
  end
end
