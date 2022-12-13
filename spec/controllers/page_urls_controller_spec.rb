require "rails_helper"

RSpec.describe PageUrlsController do
  describe 'GET index' do
    it 'return 100 most visited links' do
      [*0..110].each { |i| PageUrlShort.create(origin_url: "foo#{i}.com", view_counter: i) }
      get :index
      expect(JSON.parse(response.body)).to eq(JSON.parse(PageUrlShort.order_by_view_counter.limit(100).to_json))
    end
  end

  describe 'POST create' do
    it 'should create a PageUrlShort' do
      post :create, params: { url: 'foo.com' }
      expect(PageUrlShort.last.origin_url).to eq('foo.com')
    end
  end

  describe 'GET show' do
    it 'should get a PageUrlShort' do
      page_url_short = PageUrlShort.create(origin_url: 'foo.com')
      get :show, params: { id: page_url_short.redirect_url }
      expect(JSON.parse(response.body)).to eq(JSON.parse({ origin_url: 'foo.com' }.to_json))
    end
  end
end