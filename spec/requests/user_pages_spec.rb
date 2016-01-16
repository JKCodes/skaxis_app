require 'rails_helper'
require 'support/utilities.rb'

RSpec.describe "UserPages", type: :request do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { is_expected.to have_content('Sign up') }
    it { is_expected.to have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { is_expected.to have_content(user.name) }
    it { is_expected.to have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Test User"
        fill_in "Email",        with: "tester@example.com"
        fill_in "Password",     with: "secret"
        fill_in "Confirmation", with: "secret"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "tester@example.com")}

        it { is_expected.to have_link('Log out') }
        it { is_expected.to have_title(user.name) }
        it { is_expected.to have_selector('div.alert.alert-success', text: 'Welcome') }
      end                            
    end
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        
        it { is_expected.to have_title('Sign up') }
        it { is_expected.to have_content('error') }
      end
    end
  end
end
