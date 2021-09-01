# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CancelReservationJob, type: :job do
  let(:screening) { create(:screening, start_time: Time.now - 15.minutes) }
  let(:role) { create(:role) }
  let(:user) { create(:user) }

  before do
    GenerateSeats.new(screening.cinema_hall_id, screening.id).call
  end
  let(:seat_ids) { screening.seats.first(2).map(&:id) }
  let!(:reservation) { create(:reservation, user: user, screening: screening) }

  before do
    AssignSeats.new(reservation.id, seat_ids, screening.id).call
  end

  describe 'perform_later' do
    it 'uplodas a reservation' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        CancelReservationJob.perform_later(reservation)
      end.to have_enqueued_job
        .with(reservation)
    end
  end
end
