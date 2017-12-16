require "rails_helper"

RSpec.describe TakenPolicy, type: :service do
  describe "#applies?" do
    let(:user) { double }
    let(:book) { double }
    let(:service) { described_class.new(user: user, book: book) }

    let(:reservation) { double }

    before do
      allow(book).to receive_messages(reservations: reservation)
    end

    context "when book not taken and reservations empty" do
      let(:reservation) {
        instance_double(
          ActiveRecord::Relation,
          empty?: true,
          find_by: nil
        )
      }
      it { expect(service.applies?).to be_truthy }
    end

    context "when book taken" do
      let(:reservation) {
        instance_double(
          ActiveRecord::Relation,
          empty?: true,
          find_by: "not nil"
        )
      }
      it { expect(service.applies?).to be_falsey }
    end
  end
end