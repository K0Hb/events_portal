require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:current_user1) { FactoryBot.create(:user) }
  let(:current_user2) { FactoryBot.create(:user) }

  let(:event) { FactoryBot.create(:event, user: current_user1) }
  let(:event_with_pin) { FactoryBot.create(:event, user: current_user1, pincode: '1234') }

  let(:cookie) { { "events_#{event_with_pin.id}_pincode" => '1234' } }

  let(:owner) { UserContext.new(current_user1, {}) }
  let(:not_owner) { UserContext.new(current_user2, {}) }
  let(:not_owner_with_pin) { UserContext.new(current_user2, cookie) }
  let(:anonimous_user) { UserContext.new(nil, {}) }

  subject { described_class }

  describe '#edit, #update, #destroy' do
    context 'when user is not owner' do
      permissions :edit?, :update?, :destroy? do
        it 'not permit' do
          is_expected.not_to permit(not_owner, event)
        end
      end
    end

    context 'when user is not logged' do
      permissions :edit?, :update?, :destroy? do
        it 'not permit' do
          is_expected.not_to permit(anonimous_user, event)
        end
      end
    end

    context 'when user is the owner' do
      permissions :edit?, :destroy?, :update? do
        it 'permit' do
          is_expected.to permit(owner, event)
        end
      end
    end
  end

  describe '#create' do
    context 'registered user create event' do
      permissions :create? do
        it 'permit' do
          is_expected.to permit(owner, Event)
        end
        it 'permit' do
          is_expected.to permit(not_owner, Event)
        end
      end
    end

    context 'not registered user create event' do
      permissions :create? do
        it 'not permit' do
          is_expected.not_to permit(anonimous_user, Event)
        end
      end
    end
  end
end
