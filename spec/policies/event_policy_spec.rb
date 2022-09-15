require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:current_user1) { User.new(id: 1) }
  let(:current_user2) { User.new(id: 2) }
  let(:event) { Event.new(user: current_user1) }

  subject { described_class }

  describe '#edit, #update, #destroy' do
    context 'when user is not owner' do
      permissions :edit?, :update?, :destroy? do
        it 'not permit' do
          is_expected.not_to permit(current_user2, event)
        end
      end
    end

    context 'when user is not logged' do
      permissions :edit?, :update?, :destroy? do
        it 'not permit' do
          is_expected.not_to permit(nil, Event)
        end
      end
    end

    context 'when user is the owner' do
      permissions :edit?, :destroy?, :update? do
        it 'permit' do
          is_expected.to permit(current_user1, event)
        end
      end
    end
  end

  describe '#create' do
    context 'registered user create event' do
      permissions :create? do
        it 'permit' do
          is_expected.to permit(current_user1, :event)
        end
        it 'permit' do
          is_expected.to permit(current_user2, :event)
        end
      end
    end

    context 'not registered user create event' do
      permissions :create? do
        it 'not permit' do
          is_expected.not_to permit(nil, Event)
        end
      end
    end
  end
end
