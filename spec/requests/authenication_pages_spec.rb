require 'rails_helper'

RSpec.describe "AuthenicationPages", type: :request do
  subject { page }

  describe "login page" do
    before { visit login_path }

    it { is_expected.to have_content('Log in') }
    it { is_expected.to have_title('Log in') }
  end

  describe 'login' do
    before { visit login_path }

    describe "with invalid information" do
      before { click_button "Log in" }
      
      it { is_expected.to have_selector('div.alert.alert-danger') }
      it { is_expected.to have_title('Log in') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { is_expected.not_to have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_login(user) }

      it { is_expected.to have_title(user.name) }
      it { is_expected.to have_link('Profile', href: user_path(user)) }
      it { is_expected.to have_link('Log out', href: logout_path) }
      it { is_expected.not_to have_link('Log in', href: login_path) }

      describe "followed by logout" do
        before { click_link "Log out" }
        it { is_expected.to have_link "Log in" }
      end
    end
  end
end
