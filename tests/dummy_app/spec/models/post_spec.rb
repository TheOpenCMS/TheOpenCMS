require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'Sort posts using' do  
    before(:each) do
      3.times { create :post }
    end

    it 'method min to max' do
      expect(Post.min2max(:id).pluck(:id)).to eq [1, 2, 3]
    end

    it 'method max to min' do
      expect(Post.max2min(:id).pluck(:id)).to eq [3, 2, 1]
    end
  end

  describe 'Use simple_sort for sorting' do
    subject { Post.simple_sort(params).pluck(column) }
    let(:params) { { sort_column: column, sort_type: type_sort } }
        
    describe 'column ID' do
      before(:each) do
        3.times { create :post }
      end
      let(:column) { :id }

      context ' by ACS' do
        let(:type_sort) { 'asc' }
        
        it { is_expected.to eq [3, 2, 1] }
      end

      context 'by DESC' do
        let(:type_sort) { 'desc' }

        it { is_expected.to eq [1, 2, 3] }
      end
    end

    describe 'column Title' do
      before(:each) do
        create :post, title: 'aaa'
        create :post, title: 'bbb'
        create :post, title: 'ccc'
      end
      let(:column) { :title }

      context 'by ACS' do
        let(:type_sort) { 'asc' }

        it { is_expected.to eq ['ccc', 'bbb', 'aaa'] }
      end

      context 'by DESC' do
        let(:type_sort) { 'desc' }

        it { is_expected.to eq ['aaa', 'bbb', 'ccc'] }
      end
    end

    describe 'with wrong params' do
      subject { Post.simple_sort(params).to_sql }

      before(:each) do
        3.times { create :post }
      end

      context 'sort type' do
        let(:type_sort) { 'aZc' }
        let(:column) { :title }

        it { is_expected.to eq 'SELECT "posts".* FROM "posts" ORDER BY posts.title ASC' }
      end
      
      context 'column to sort' do
        let(:type_sort) { 'ASC' }
        let(:column) { :ANY_WRONG_COLUMN_NAME }

        it { is_expected.to eq 'SELECT "posts".* FROM "posts"' }
      end

      context 'sort type and column to sort' do
        let(:type_sort) { 'aZc' }
        let(:column) { :ANY_WRONG_COLUMN_NAME }

        it { is_expected.to eq 'SELECT "posts".* FROM "posts"' }
      end 
    end

    describe 'after sort by Title' do
      before(:each) do
        3.times { create :post }
      end

      context 'sorted by ID and DESC' do
        let(:column) { :id }
        let(:type_sort) { 'ASC' }

        it 'is valid' do
          expect(Post.order('title DESC').simple_sort(params).to_sql).to eq 'SELECT "posts".* FROM "posts" ORDER BY posts.id DESC'
        end
      end
    end
  end
end
