require "rails_helper"

RSpec.describe GivenBackPolicy, type: :service do
  let(:user) { double }
  let(:book) { double }
  subject { described_class.new(user: user, book: book) }

  before {
    allow(book).to receive_message_chain(:reservations, :find_by).with(no_args).
      with(user: user, status: 'TAKEN').and_return(reservation)
  }

  describe '#applies?' do

    context 'without reservations' do
       let(:reservation) { nil }
       it {
         expect(subject.applies?).to be_falsey
       }
     end

     context 'with reservation' do
       let(:reservation) { double }
       it {
         expect(subject.applies?).to be_truthy
       }
     end
  end
end