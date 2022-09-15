require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:current_user) { User.new }
  let(:another_user) { User.new(id: 1) }
  let(:event) { Event.new(user: current_user) }

  subject { described_class }

  describe '#edit, #update, #destroy' do
    context 'when user is not owner' do
      permissions :edit?, :update?, :destroy? do
        it 'not permit' do
          is_expected.not_to permit(another_user, event)
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
          is_expected.to permit(current_user, event)
        end
      end
    end
  end

  describe '#create' do
    context 'registered user create event' do
      permissions :create? do
        it 'permit' do
          is_expected.to permit(another_user, :event)
        end
        it 'permit' do
          is_expected.to permit(current_user, :event)
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
