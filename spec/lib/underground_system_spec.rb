# frozen_string_literal: true

describe UndergroundSystem do
  subject { UndergroundSystem.new }

  describe '#check_in' do
    it 'stores the check in station and time' do
      subject.check_in(1, 'Station A', 10)
      expect(subject.check_ins).to eq(1 => ['Station A', 10])
    end
  end

  describe '#check_out' do
    it 'stores the journey times' do
      subject.check_in(1, 'Station A', 10)
      subject.check_out(1, 'Station B', 20)
      expect(subject.journey_times).to eq(['Station A', 'Station B'] => [10, 1])
    end
  end

  describe '#get_average_time' do
    it 'calculates the average travel time for a single trip' do
      subject.check_in(1, 'Station A', 10)
      subject.check_out(1, 'Station B', 20)
      expect(subject.get_average_time('Station A', 'Station B')).to eq(10)
    end

    it 'calculates the average travel time for multiple trips' do
      subject.check_in(1, 'Station A', 10)
      subject.check_out(1, 'Station B', 20)
      subject.check_in(2, 'Station A', 30)
      subject.check_out(2, 'Station B', 40)
      expect(subject.get_average_time('Station A', 'Station B')).to eq(10)
    end

    it 'returns nil for non-existent routes' do
      subject.check_in(1, 'Station A', 10)
      subject.check_out(1, 'Station B', 20)
      subject.check_in(2, 'Station A', 30)
      subject.check_out(2, 'Station B', 40)
      expect(subject.get_average_time('Station B', 'Station A')).to be_nil
    end
  end
end
