require 'rails_helper'

RSpec.describe V1::TripsController, type: :controller do
  before(:each) do
    # create user and sign her in
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
    allow(controller).to receive(:current_user).and_return(@current_user)

    @valid_attributes = {
      destination: 'Lima',
      start_date: '2015-01-10',
      end_date: '2015-01-26',
      comment: 'vacation time',
      user_id: @current_user.id
    }

    @invalid_attributes = {
      description: 'invalid attribute'
    }

    # add vendor trip mime type and version to each request's header
    @request.env['HTTP_ACCEPT'] = 'application/vnd.trips+json; version=1'
  end
  
  let(:trips_set) do
    # a small set of trips for testing next month's trips and filtering
    [
      Trip.new({destination: 'Lima', start_date: '2015-01-10', end_date: '2015-01-26', comment: 'vacation time', user_id: @current_user.id}),
      Trip.new({destination: 'Paris', start_date: '2015-02-16', end_date: '2015-02-18', comment: 'more vacation time', user_id: @current_user.id}),
      Trip.new({destination: 'Madrid', start_date: '2015-03-03', end_date: '2015-03-04', comment: 'work', user_id: @current_user.id}),
      Trip.new({destination: 'Juarez', start_date: '2015-03-20', end_date: '2015-04-05', comment: 'some more work', user_id: @current_user.id}),
      Trip.new({destination: 'Austin', start_date: '2015-04-01', end_date: '2015-04-11', comment: 'and some more', user_id: @current_user.id}),
    ]
  end

  describe "sign in" do
    it "should have a current_user" do
      expect(@current_user).not_to be_nil
    end
  end

  describe "GET #index" do
    it "assigns all trips as @trips" do
      trips_set.map(&:save)
      get :index
      expect(assigns(:trips).count).to eq(trips_set.count)
    end
  end

  describe "GET #show" do
    it "assigns the requested trip as @trip" do
      trip = Trip.create! @valid_attributes
      trip.reload
      get :show, { tid: trip.tid }
      expect(assigns(:trip)).to eq(trip)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Trip" do
        expect {
          post :create, { trip: @valid_attributes }
        }.to change(Trip, :count).by(1)
      end

      it "assigns a newly created trip as @trip" do
        post :create, { trip: @valid_attributes }
        expect(assigns(:trip)).to be_a(Trip)
        expect(assigns(:trip)).to be_persisted
      end
    end

    context "with invalid params" do
      before(:each) do
        ActionController::Parameters.action_on_unpermitted_parameters = :log
      end

      it "assigns a newly created but unsaved trip as @trip" do
        post :create, { trip: @invalid_attributes }
        expect(assigns(:trip)).to be_a_new(Trip)
      end

      it "returns status unprocessable entity" do
        post :create, { trip: @invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          destination: 'Arequipa'
        }
      end

      it "updates the requested trip" do
        trip = Trip.create! @valid_attributes
        trip.reload
        put :update, { tid: trip.tid, trip: new_attributes }
        trip.reload
        expect(trip.destination).to eq(new_attributes[:destination])
      end

      it "assigns the requested trip as @trip" do
        trip = Trip.create! @valid_attributes
        trip.reload
        put :update, { tid: trip.tid, trip: @valid_attributes }
        expect(assigns(:trip)).to eq(trip)
      end
    end

    context "with invalid params" do
      it "raises ActionController::UnpermittedParameters exception" do
        ActionController::Parameters.action_on_unpermitted_parameters = :raise
        trip = Trip.create! @valid_attributes
        trip.reload
        begin
          put :update, { tid: trip.tid, trip: @invalid_attributes }
        rescue => e
          expect(e.class).to eq(ActionController::UnpermittedParameters)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested trip" do
      trip = Trip.create! @valid_attributes
      trip.reload
      expect {
        delete :destroy, { tid: trip.tid }
      }.to change(Trip, :count).by(-1)
    end
  end

  describe "#next_month_trips" do
    before(:each) do
      allow(Date).to receive(:today).and_return(Date.parse('2015-02-16'))
      trips_set.map(&:save)
    end

    it "returns a list of trips in the next month" do
      post :next_month_trips
      expect(assigns(:trips)).to eq([trips_set[2], trips_set[3]])
    end
  end

  describe "#filter" do
    before(:each) do
      trips_set.map(&:save)
    end

    context "with invalid params" do
      it "returns bad request" do
        post :filter, {}
        expect(response.status).to eq(400)
      end
    end

    context "with valid destination params that exists in the trips set" do
      it "returns non-empty result set" do
        post :filter, { destination: 'ma' }
        expect(assigns(:trips).count).to eq 2
      end

      it "returns specific matching records" do
        post :filter, { destination: 'ma' }
        expect(assigns(:trips).to_a).to eq [trips_set[0], trips_set[2]]
      end
    end
  end

end
