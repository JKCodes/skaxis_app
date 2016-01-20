require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  subject { page }
  before { ActionMailer::Base.deliveries.clear }
  let(:user) { FactoryGirl.create(:user) }

  describe "password resets" do
    before { visit new_password_reset_path }
    
    it { is_expected.to have_title('Forgot password') }

    describe "with invalid email" do
      before do 
        fill_in "Email", with: '' 
        click_button "Submit"
      end

      it { is_expected.to have_title('Forgot password') }
    end

    describe "with valid email" do
      before do
        fill_in "Email", with: user.email
        click_button "Submit"
      end

      it "should send a link to email address" do
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      describe "on password reset form" do

        describe "with wrong email" do
          before do
            user.reset_token = User.new_token 
            user.reset_sent_at = 1.hour.ago
            visit edit_password_reset_path(user.reset_token, email: user.email)
          end

          it { is_expected.to have_title(full_title('')) }
        end
      end
    end  
  end
end
