require 'rails_helper'
require 'date'

RSpec.describe Trip, type: :model do
  before do
    @current_user = FactoryGirl.create(:user)
    @trip = Trip.new(destination: 'Peru',
      start_date: '2015-01-10',
      end_date: '2015-01-26',
      comment: 'visiting Machu Picchu',
      user_id: @current_user.id,
      tid: '2d42bc17-c587-4114-a92f-8e7e579d6c1d')
  end

  subject { @trip }

  describe 'when destination is not present' do
    before { @trip.destination = '' }
    it { should_not be_valid }
  end

  describe 'when start_date is not present' do
    before { @trip.start_date = '' }
    it { should_not be_valid }
  end

  describe 'when end_date is not present' do
    before { @trip.end_date = '' }
    it { should_not be_valid }
  end

  describe 'when user_id is not present' do
    before { @trip.user_id = '' }
    it { should_not be_valid }
  end

  describe 'when end_date is smaller than start_date' do
    before { @trip.end_date = @trip.start_date - 1 }
    it { should_not be_valid }
  end
end