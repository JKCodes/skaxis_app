require 'rails_helper'
require 'support/utilities.rb'

RSpec.describe "MainPages", type: :request do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { is_expected.to have_content('Skaxis') }
    it { is_expected.to have_title(full_title('')) }
    it { is_expected.not_to have_title('Skaxis - Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { is_expected.to have_content('Help') }
    it { is_expected.to have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { is_expected.to have_content('About') }
    it { is_expected.to have_title(full_title('About Me')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { is_expected.to have_content('Contact') }
    it { is_expected.to have_title(full_title('Contact')) }
  end
  
  describe "Terms page" do
    before { visit terms_path }

    it { is_expected.to have_content('Terms') }
    it { is_expected.to have_title(full_title('Terms')) }
  end

  describe "Privacy page" do
    before { visit privacy_path }

    it { is_expected.to have_content('Privacy') }
    it { is_expected.to have_title(full_title('Privacy')) }
  end
end
