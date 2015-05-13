require_relative '../../../../spec_helper'

describe Cortex::Client::APIs::V1 do
  let(:path) { '/path' }
  let(:options) {
    {
      faraday_options: {
        faraday_adapter: :test
      },
      oauth_options: {
        oauth_adapter: Cortex::Client::Mocks::OAuth
      }
    }
  }

  describe :get do
    it 'makes the request to the proper url' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/path?access_token=token') { |env| [200, {}, 'ok'] }
      end

      options[:faraday_options][:faraday_params] = stubs

      client = Cortex::Client::APIs::V1.new(options)
      expect(client.get(path).body).to eq('ok')
    end

    it 'makes the request with the proper serialize parameters' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/path?access_token=token&param1=true') { |env| [200, {}, 'ok'] }
      end

      options[:faraday_options][:faraday_params] = stubs

      client = Cortex::Client::APIs::V1.new(options)
      expect(client.get(path, {param1: true}).body).to eq('ok')
    end
  end

  describe :post do
    it 'makes the request to the proper url' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.post('/path') { |env| [200, {}, 'ok'] }
      end

      options[:faraday_options][:faraday_params] = stubs

      client = Cortex::Client::APIs::V1.new(options)
      expect(client.post(path, 'body').body).to eq('ok')
    end
  end

  describe :put do
    it 'makes the request to the proper url' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.put('/path') { |env| [200, {}, 'ok'] }
      end

      options[:faraday_options][:faraday_params] = stubs

      client = Cortex::Client::APIs::V1.new(options)
      expect(client.put(path, 'body').body).to eq('ok')
    end
  end

  describe :delete do
    it 'makes the request to the proper url' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.delete('/path') { |env| [200, {}, 'ok'] }
      end

      options[:faraday_options][:faraday_params] = stubs

      client = Cortex::Client::APIs::V1.new(options)
      expect(client.delete(path).body).to eq('ok')
    end
  end
end

describe Cortex::Client::APIs::V1::Endpoints do
    it { is_expected.to have_constant(:POST_FEED)   }
    it { is_expected.to have_constant(:SINGLE_ITEM) }
    it { is_expected.to have_constant(:PUBLISHED)   }
    it { is_expected.to have_constant(:RELATED)     }
    it { is_expected.to have_constant(:AUTHORS)     }
    it { is_expected.to have_constant(:FILTERS)     }
    it { is_expected.to have_constant(:USER_AUTHOR) }
end