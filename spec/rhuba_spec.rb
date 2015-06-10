require 'spec_helper'

describe Rhubarb do

  let(:all) { Rhubarb.all }
  let(:req_keys) { Rhubarb::REQUIRED_KEYS }
  let(:rhuarb_season) { Rhubarb.whats_good Time.now.change(month: 5) }

  it 'has the all' do
    expect {
      all
      req_keys
    }.to_not raise_error
  end

  it 'checks for required fields' do
    all.each do |v|
      req_keys.each do |rq|
        expect(v.key?(rq.to_sym)).to be(true), "key #{rq.to_sym} missing"
      end
    end
  end

  it 'knows whats good' do
    expect(rhuarb_season).to_not be_empty
  end

  it 'formats' do
    results = Rhubarb.format(rhuarb_season)
    expect(results).to include('rhubarb: beginning of April -> end of June')
  end

  it 'generates tldr' do
    results = Rhubarb.tldr(rhuarb_season)
    expect(results).to include('rhubarb')
  end
end
