describe Travis::Queue::ForceLinuxSudoRequired do
  let(:config) { {} }
  let(:owner) { FactoryGirl.build(:user, login: 'cabbagen') }
  let(:enabled_for_all?) { false }
  let(:active?) { false }

  subject { described_class.new(owner) }

  before do
    Travis::Features
      .stubs(:enabled_for_all?)
      .with(:linux_sudo_required)
      .returns(enabled_for_all?)
    Travis::Features
      .stubs(:owner_active?)
      .with(:linux_sudo_required, owner)
      .returns(active?)
    Travis::Scheduler.logger.stubs(:info)
  end

  context 'when enabled for all' do
    let(:enabled_for_all?) { true }

    it 'applies' do
      expect(subject.apply?).to be true
    end
  end

  context 'when owner is active' do
    let(:active?) { true }

    it 'applies' do
      expect(subject.apply?).to be true
    end
  end
end
