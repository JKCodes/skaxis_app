require 'rails_helper'
require 'support/utilities.rb'

RSpec.describe "UserPages", type: :request do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { is_expected.to have_content('Sign up') }
    it { is_expected.to have_title(full_title('Sign up')) }
  end
end
