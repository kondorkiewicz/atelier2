require "rails_helper"

RSpec.describe Book, type: :model do
  describe "#can_take?" do
    let(:book) { described_class.new }
    let(:user) { double }
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
      it "is truthy" do
        expect(book.can_take?(user)).to be_truthy
      end
    end

    context "when book taken " do
      let(:reservation) {
        instance_double(
          ActiveRecord::Relation,
          empty?: true,
          find_by: "not nil"
        )
      }
      it { expect(book.can_take?(user)).to be_falsey }
    end

  end
end