require 'spec_helper'

require_relative '../lib/ally/detector/quote'

describe Ally::Detector::Quote do

  context 'detect a quote' do
    it 'by itself' do
      subject.inquiry('carlos "extreme" danger').detect.should == ['extreme']
    end

    it 'with a mix of quote types' do
      subject.inquiry('"you can\'t handle the truth"')
        .detect.should == ['you can\'t handle the truth']
    end

    it 'when there no quote' do
      subject.inquiry('that is charlie\'s coat.')
        .detect.should.nil?
    end

    it 'when there are two no quotes' do
      subject.inquiry('that\'s is charlie\'s coat.')
        .detect.should.nil?
    end

    it 'when using single quotes' do
      subject.inquiry('oh, she likes to \'run around\' a lot.')
        .detect.should == ['run around']
    end

    it 'when theres an apostrophe at the end of a word' do
      subject.inquiry('we should go to Changs\' house')
        .detect.should.nil?
    end

    # this one may not have a feasible means of working
    # it 'when theres an apostrophe inside a single quotes' do
    #  subject.inquiry('They would like to \'head to chang\'s house')
    #    .detect.should == ['head to chang\'s house']
    # end
  end

end
