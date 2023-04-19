require_relative 'filtering_array'
require 'rspec'

RSpec.describe '#filter_products' do
  let(:products) do
    [
      ['Product A', "100", "2010"],
      ['Product B', "200", "2015"],
      ['Product C', "300", "2020"],
      ['Product D', "400", "2018"],
      ['Product E', "500", "2019"]
    ]
  end

  context 'filtering by year equals to' do
    it 'returns the products with the specified year' do
      queries = [['Type1', '2018']]
      expect(filter_products(products, queries)).to eq([['Product D']])
    end

    it 'returns an empty array when there are no products with the specified year' do
      queries = [['Type1', '2022']]
      expect(filter_products(products, queries)).to eq([[]])
    end
  end

  context 'filtering by price lower than' do
    it 'returns the products with a price lower than the specified value' do
      queries = [['Type2', '300']]
      expect(filter_products(products, queries)).to eq([['Product A','Product B']])
    end

    it 'returns an empty array when there are no products with a price lower than the specified value' do
      queries = [['Type2', '50']]
      expect(filter_products(products, queries)).to eq([[]])
    end
  end

  context 'when filtering by price greater than' do
    it 'returns the products with a price greater than the specified value' do
      queries = [['Type3', '300']]
      expect(filter_products(products, queries)).to eq([['Product D','Product E']])
    end

    it 'returns an empty array when there are no products with a price greater than the specified value' do
      queries = [['Type3', '600']]
      expect(filter_products(products, queries)).to eq([[]])
    end
  end

  context 'filtering with multiple queries' do
    it 'returns the products by year and higher price' do
      queries = [['Type1', '2018'], ['Type3', "300"]]
      expect(filter_products(products, queries)).to eq([['Product D'], ['Product D', 'Product E']])
    end

    it 'returns the products by year and higher price (empty)' do
      queries = [['Type1', '2010'], ['Type3', '500']]
      expect(filter_products(products, queries)).to eq([['Product A'],[]])
    end

    it 'returns the products by year and lower price' do
      queries = [['Type1', '2018'], ['Type2', '150']]
      expect(filter_products(products, queries)).to eq([['Product D'],['Product A']])
    end

    it 'returns the products by year(empty) and lower price' do
      queries = [['Type1', '2022'], ['Type2', '150']]
      expect(filter_products(products, queries)).to eq([[], ['Product A']])
    end
  end
end