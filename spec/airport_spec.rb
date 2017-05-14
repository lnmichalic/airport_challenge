require 'airport'

describe Airport do
  let(:airport) { Airport.new }
  let(:plane) { double('plane') }
  let(:weather) { double('weather') }
  describe '#land' do
    it 'responds to #land' do
      is_expected.to respond_to(:land)
    end
    it 'responds to #land with the arguement "plane"' do
      is_expected.to respond_to(:land).with(1).argument
    end
    it 'lands an airplane and stores it in airport' do
      airport.land(plane)
      expect(airport.landed_planes).to eq [plane]
    end
    it 'confirms plane has landed with message "Plane has landed"' do
      expect(airport.land(plane)).to eq 'Plane has landed'
    end
    it "raises error when the weather is stormy" do
      allow(airport).to receive(:bad_conditions?).and_return(true)
      expect { airport.land(plane) }.to raise_error(RuntimeError, "Cannot land when it's stormy")
    end
    it 'raises error when the airport is full' do
      Airport::DEFAULT_CAPACITY.times { airport.land(plane) }
      expect { airport.land(plane) }.to raise_error(RuntimeError, "Cannot land when airport is full")
    end
  end
  describe '#instruct_plane_takeoff' do
    it 'responds to #instruct_plane_takeoff' do
      is_expected.to respond_to(:instruct_plane_takeoff)
    end
    it 'when #instruct_plane_takeoff happens, plane leaves airport' do
      airport.land(plane)
      airport.instruct_plane_takeoff(plane)
      expect(airport.landed_planes).to be_empty
    end
    it 'confirms plane has taken off with message "Plane has taken off"' do
      airport.land(plane)
      expect(airport.instruct_plane_takeoff(plane)).to eq 'Plane has taken off'
    end
    it "raises error when the weather is stormy" do
      allow(airport).to receive(:bad_conditions?).and_return(true)
      expect { airport.instruct_plane_takeoff(plane) }.to raise_error(RuntimeError, "Cannot take off when it's stormy")
    end
  end
  describe '#bad_conditions' do
    it 'responds to airport.bad_conditions?' do
      expect(airport).to respond_to(:bad_conditions?)
    end
    it 'returns boolean of weather is stormy?' do
      expect(airport.bad_conditions?).to be(true).or be(false)
    end
  end
  describe '#capacity' do
    it 'responds to airport.capacity' do
      expect(airport).to respond_to(:capacity)
    end
    it 'DEFAULT_CAPACITY is set at instantiation' do
      expect(airport.capacity).to eq Airport::DEFAULT_CAPACITY
    end
    it 'capacity changes to desired volume when set' do
      airport.capacity = 15
      expect(airport.capacity).to eq 15
    end
  end

end
