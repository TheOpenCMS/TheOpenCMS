# coding: UTF-8
require 'spec_helper'

describe 'StringToSlug' do
  context 'String tests' do
    it 'should be true' do
      "Привет Мир! Hello world!".to_slug_param.should eq "privet-mir-hello-world"
      "Документ.doc".to_slug_param.should eq "dokument-doc"
    end
  end

  context 'Filename test' do
    it 'should be true' do
      "/doc/dir/test/document.doc".to_slug_param.should     eq "doc-dir-test-document-doc"
      "/doc/dir/test/document.doc".slugged_filename.should  eq "document.doc"
      "/доки/dir/тест/документ.doc".slugged_filename.should eq "dokument.doc"
      "/доки/dir/тест/документ".slugged_filename.should     eq "dokument"
      "/доки/dir/тест/доку мент".slugged_filename.should    eq "doku-ment"

      String.slugged_filename("/доки/dir/тест/доку мент").should eq "doku-ment"
    end
  end
end