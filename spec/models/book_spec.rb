require "rails_helper"

RSpec.describe Book, type: :model do
  let(:book) { described_class.new }
  let(:user) { double }
  let(:reservation) { double }

  before do
    allow(book).to receive_messages(reservations: array)
  end

  describe "#can_reserve?" do
    context "without reservations" do
      let(:array) { instance_double(ActiveRecord::Relation, find_by: nil) }
      it "should be truthy" do
        expect(book.can_reserve?(user)).to be_truthy
      end
    end

    context "with reservation" do
      let(:array) { instance_double(ActiveRecord::Relation, find_by: reservation) }
      it "should be falsey" do
        expect(book.can_reserve?(user)).to be_falsey
      end
    end
  end
end