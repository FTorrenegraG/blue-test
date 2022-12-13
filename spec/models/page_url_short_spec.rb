require 'rails_helper'

RSpec.describe PageUrlShort, type: :model do
  describe 'validations' do
    context 'presence of origin_url' do
      it 'should invalid' do
        expect(PageUrlShort.new(origin_url: nil).valid?).to be_falsey
      end

      it 'should valid' do
        expect(PageUrlShort.new(origin_url: 'foo.com').valid?).to be_truthy
      end
    end

    context 'uniqueness of origin_url' do
      it 'should invalid' do
        PageUrlShort.create(origin_url: 'foo.com')
        expect(PageUrlShort.new(origin_url: 'foo.com').valid?).to be_falsey
      end

      it 'should valid' do
        PageUrlShort.create(origin_url: 'foo.com')
        expect(PageUrlShort.new(origin_url: 'foo2.com').valid?).to be_truthy
      end
    end
  end

  describe 'public methods' do
    context '#sum_view_counter' do
      it 'should increment the view counter' do
        page_url_short = PageUrlShort.create(origin_url: 'foo.com')
        expect { page_url_short.sum_view_counter }.to change { PageUrlShort.last.view_counter }.from(0).to(1)
      end
    end
  end

  describe 'private methods' do
    context '#short_url' do
      it 'set redirect_url before create' do
        page_url_short = PageUrlShort.new(origin_url: 'foo.com')
        expect { page_url_short.save }.to change { page_url_short.redirect_url }
      end
    end
  end
end
