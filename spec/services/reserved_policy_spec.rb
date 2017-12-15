require "rails_helper"

RSpec.describe ReservedPolicy, type: :service do
  let(:user) { double }
  let(:book) { instance_double(Book, reservations: reservation) }
  let(:service) { described_class.new(user: user, book: book) }

  describe "#applies?" do

    context "without reservations" do
      let(:reservation) { instance_double(ActiveRecord::Relation, find_by: nil) }
      it { expect(service.applies?).to be_truthy }
    end

    context "with reservation" do
      let(:reservation) { instance_double(ActiveRecord::Relation, find_by: "something") }
      it { expect(service.applies?).to be_falsey }
    end

  end
end