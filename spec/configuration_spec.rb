# spec/zeitwerk_spec.rb
require 'rails_helper'

RSpec.describe 'Zeitwerk' do
  it 'eager loads all files' do
    expect do
      Zeitwerk::Loader.eager_load_all
    end.to_not raise_error
  end
end
