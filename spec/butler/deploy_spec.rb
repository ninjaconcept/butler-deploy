require 'spec_helper'

describe Butler::Deploy do
  it 'has a version number' do
    expect(Butler::Deploy::VERSION).not_to be nil
  end
end
