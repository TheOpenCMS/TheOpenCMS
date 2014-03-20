# coding: UTF-8
require 'spec_helper'

describe 'StringToSlug' do
  context 'String tests' do
    it 'should be true' do
      "Привет Мир! Hello world!".to_slug_param.should eq "privet-mir-hello-world"
      "Документ.doc".to_slug_param.should eq "dokument-doc"
    end

    it 'When wrong translation' do
      "Привет Мир! Hello world!".to_slug_param(locale: :en).should eq "hello-world"
      "Документ.doc".to_slug_param(locale: :en).should eq "doc"
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

    it 'When wrong translation' do
      "/doc/dir/test/document.doc".to_slug_param(locale: :ru).should     eq "doc-dir-test-document-doc"
      "/doc/dir/test/document.doc".slugged_filename(locale: :ru).should  eq "document.doc"
      
      "/доки/dir/тест/документ.doc".slugged_filename(locale: :en).should eq ".doc"
      "/доки/dir/тест/документ".slugged_filename(locale: :en).should     eq ""
      "/доки/dir/тест/доку мент".slugged_filename(locale: :en).should    eq ""

      String.slugged_filename("/доки/dir/тест/доку мент", locale: :en).should eq ""
    end
  end

  context 'Full path to file' do
    it 'should be true' do
      "/doc/dir/test/document.doc".slugged_file.should  eq "/doc/dir/test/document.doc"
      "/доки/dir/тест/документ.doc".slugged_file.should eq "/доки/dir/тест/dokument.doc"
      "/доки/dir/тест/документ".slugged_file.should     eq "/доки/dir/тест/dokument"
      "/доки/dir/тест/доку мент".slugged_file.should    eq "/доки/dir/тест/doku-ment"

      String.slugged_file("/доки/dir/тест/доку мент").should eq "/доки/dir/тест/doku-ment"
    end

    it 'When wrong translation' do
      "/doc/dir/test/document.doc".slugged_file(locale: :en).should  eq "/doc/dir/test/document.doc"
      "/доки/dir/тест/документ.doc".slugged_file(locale: :en).should eq "/доки/dir/тест/.doc"
      
      "/доки/dir/тест/документ".slugged_file(locale: :en).should     eq "/доки/dir/тест/"
      "/доки/dir/тест/доку мент".slugged_file(locale: :en).should    eq "/доки/dir/тест/"

      String.slugged_file("/доки/dir/тест/доку мент", locale: :en).should eq "/доки/dir/тест/"
    end
  end

  context 'Delimiter' do
    it 'should be true' do
      "Привет Мир! Hello world!".to_slug_param(delimiter: '_').should eq "privet_mir_hello_world"
      "Документ.doc".to_slug_param(delimiter: '_').should eq "dokument_doc"

      "/доки/dir/тест/документ".slugged_file(delimiter: '_').should      eq "/доки/dir/тест/dokument"
      "/доки/dir/тест/доку мент".slugged_file(delimiter: '_').should     eq "/доки/dir/тест/doku_ment"
      "/доки/dir/тест/доку мент".slugged_filename(delimiter: '_').should eq "doku_ment"
    end
  end

  context 'Scopes' do
    it 'should be true' do
      ActionController::Base.to_s.to_slug_param(delimiter: '_').should eq 'actioncontroller_base'
    end
  end
end