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
      it { is_expected.to have_link('Users', href: users_path) }
      it { is_expected.to have_link('Profile', href: user_path(user)) }
      it { is_expected.to have_link('Settings', href: edit_user_path(user)) }
      it { is_expected.to have_link('Log out', href: logout_path) }
      it { is_expected.not_to have_link('Log in', href: login_path) }

      describe "followed by logout" do
        before { click_link "Log out" }
        it { is_expected.to have_link "Log in" }
      end
    end
  end

  describe "authorization" do

    describe "for non-logged-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Log in"
        end

        describe "after signing in" do
          
          it "should enter the desired protected page" do
            expect(page).to have_title('Edit your profile')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { is_expected.to have_title('Log in') }
        end

        describe "submitting a user update form" do 
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(login_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { is_expected.to have_title('Log in') }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "different@example.com") }
      before { valid_login user }

      describe "visiting the edit page" do
        before { visit edit_user_path(wrong_user) }
        it { is_expected.to have_title(full_title('')) }
      end

      describe "submitting a user update form" do
        before { patch user_path(wrong_user) }
        it { is_expected.to have_title(full_title('')) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { valid_login non_admin }

      describe "attempting to delete a user" do
        before { delete user_path(user) }
        it { is_expected.to have_title(full_title('')) }
      end
    end
  end
end
