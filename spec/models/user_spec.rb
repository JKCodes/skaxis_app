require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { User.new(name: "tester", email: "test@example.com", 
                            status: "my status", description: "my description",
                            password: "secret", password_confirmation: "secret") }

  describe "attributes" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:password) }
    it { is_expected.to respond_to(:password_confirmation) }
  end

  describe "validations" do

    describe "when all validations pass" do 
      it { is_expected.to be_valid }
    end

    describe "when name does not exist" do
      before { user.name = '' }
      it { is_expected.to be_invalid }
    end
    
    describe "when email does not exist" do
      before { user.email = '' }
      it { is_expected.to be_invalid }
    end

    describe "when name is too long" do
      before { user.name = "q" * 41 }
      it { is_expected.to be_invalid }
    end

    describe "when email is too long" do
      before { user.email = "q" * 49 + "@example.com" }
      it { is_expected.to be_invalid }
    end
    
    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[test@example,com test.ex.org test@example..com test@example_com ]
        addresses.each do |address|
          user.email = address
          expect(user).to be_invalid
        end
      end
    end

    describe "when email format is valid" do
      it "should be invalid" do
        addresses = %w[test@example.com t_e_s_r@example.com test.user@example.com ]
        addresses.each do |address|
          user.email = address
          expect(user).to be_valid
        end
      end
    end

    describe "when email is not unique" do
      before do
        user2 = user.dup
        user2.save
      end
      it { is_expected.to be_invalid } 
    end

    describe "when password is blank" do
      before { user.password = user.password_confirmation =  '' }
      it { is_expected.to be_invalid }
    end

    describe "when password is too short" do
      before { user.password = user.password_confirmation = 'ddddd' }
      it { is_expected.to be_invalid }
    end

    describe "when password does not match confirmation" do
      before { user.password_confirmation = 'incorrect' }
      it { is_expected.to be_invalid }
    end
  end

  describe "email address" do
    it "must be downcased before saved to database" do
      user.email = "Test@Example.cOm"
      user.save
      expect(user.email).to eq "test@example.com"
    end
  end

  describe "password" do
    it { is_expected.to respond_to(:authenticate) }
    
    describe "authenticate method values" do
      before { user.save }
      let(:queried_user) { User.find_by(email: user.email) }
     
      describe "with valid password" do
        it { is_expected.to eq queried_user.authenticate(user.password) }
      end

      describe "with invalid password" do
        it { is_expected.not_to eq queried_user.authenticate('wrong password') }
      end
    end
  end
end
