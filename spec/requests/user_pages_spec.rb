require 'rails_helper'
require 'support/utilities.rb'

RSpec.describe "UserPages", type: :request do

  subject { page }

  describe "index" do
    before do
      valid_login FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "test1", email: "test1@example.com")
      FactoryGirl.create(:user, name: "test2", email: "test2@example.com")
      visit users_path
    end

    it { is_expected.to have_title('All users') }
    it { is_expected.to have_content('All users') }

    describe "pagination" do
      
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  {User.delete_all }

      it { is_expected.to have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.status)
          expect(page).to have_selector('li', text: user.description)
        end
      end
    end

    describe "delete links" do

      it {is_expected.not_to have_link('Delete user') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          valid_login admin
          visit users_path
        end

        it { is_expected.to have_link('Delete user', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('Delete user', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { is_expected.not_to have_link('Delete user', href: user_path(admin)) }
      end
    end
  end

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
    before { ActionMailer::Base.deliveries.clear }

    let(:submit) { "Create my account" }

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Test User"
        fill_in "Email",        with: "testing@example.com"
        fill_in "Password",     with: "secret"
        fill_in "Confirmation", with: "secret"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "testing@example.com")}

        it "should send a confimration email" do
          expect(ActionMailer::Base.deliveries.size).to eq 1
        end

        describe "with account activation link" do
          it "user should not be activated" do
            expect(user.activated?).not_to eq true
          end
          
          describe "without activating the link" do
            before { valid_login(user) }
            it { is_expected.to have_title(full_title('')) }
          end

          describe "after activating the link with wrong token" do
            before { get edit_account_activation_path("invalid") }
            it { is_expected.to have_title(full_title('')) }
          end
          
          describe "after activating the link with valid token" do
            before { user.activate }
            
            it "user should be activated" do
              expect(user.activated?).to eq true
            end
          end
        end

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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      valid_login user
      visit edit_user_path(user)
    end

    describe "page" do
      it { is_expected.to have_content("Update your profile") }
      it { is_expected.to have_content("Update your status!") }
      it { is_expected.to have_content("Write something") }
      it { is_expected.to have_title("Edit your profile") }
    end

    describe "with valid information" do 
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      let(:new_status) { "New Status" }
      let(:new_description) { "New Description" }
      before do
        fill_in "Name",  with: new_name
        fill_in "Email", with: new_email
        fill_in "Update your status!", with: new_status
        fill_in "Write something about yourself!", with: new_description
        fill_in "Password", with: user.password
        fill_in "Confirm password", with: user.password
        click_button "Save changes"
      end

      it { is_expected.to have_title(new_name) }
      it { is_expected.to have_selector('div.alert.alert-success') }
      it { is_expected.to have_link('Log out', href: logout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
      specify { expect(user.reload.status).to eq new_status }
      specify { expect(user.reload.description).to eq new_description }
    end
  end
end
