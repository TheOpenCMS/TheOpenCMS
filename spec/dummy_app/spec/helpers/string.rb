# coding: UTF-8
require 'spec_helper'

describe 'StringToSlug' do
  context "readme" do
    it "testcase 1" do
      "Документ.doc".to_slug_param(locale: :ru).should eq "dokument-doc"
      "Документ.doc".to_slug_param(locale: :en).should eq "doc"

      :"Документ.doc".to_slug_param(locale: :ru).should eq "dokument-doc"
      :"Документ.doc".to_slug_param(locale: :en).should eq "doc"

      "Документ.doc".to_slug_param(sep: '_', locale: :ru).should eq "dokument_doc"
      "Документ.doc".to_slug_param(sep: '_', locale: :en).should eq "doc"

      :"Документ.doc".to_slug_param(sep: '_', locale: :ru).should eq "dokument_doc"
      :"Документ.doc".to_slug_param(sep: '_', locale: :en).should eq "doc"
    end
  end

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
      "/doc/dir/test/document.doc".slugged_filepath.should  eq "/doc/dir/test/document.doc"
      "/доки/dir/тест/документ.doc".slugged_filepath.should eq "/доки/dir/тест/dokument.doc"
      "/доки/dir/тест/документ".slugged_filepath.should     eq "/доки/dir/тест/dokument"
      "/доки/dir/тест/доку мент".slugged_filepath.should    eq "/доки/dir/тест/doku-ment"

      String.slugged_filepath("/доки/dir/тест/доку мент").should eq "/доки/dir/тест/doku-ment"
    end

    it 'When wrong translation' do
      "/doc/dir/test/document.doc".slugged_filepath(locale: :en).should  eq "/doc/dir/test/document.doc"
      "/доки/dir/тест/документ.doc".slugged_filepath(locale: :en).should eq "/доки/dir/тест/.doc"
      
      "/доки/dir/тест/документ".slugged_filepath(locale: :en).should     eq "/доки/dir/тест/"
      "/доки/dir/тест/доку мент".slugged_filepath(locale: :en).should    eq "/доки/dir/тест/"

      String.slugged_filepath("/доки/dir/тест/доку мент", locale: :en).should eq "/доки/dir/тест/"
    end
  end

  context 'sep' do
    it 'should be true' do
      "Привет Мир! Hello world!".to_slug_param(sep: '_').should eq "privet_mir_hello_world"
      "Документ.doc".to_slug_param(sep: '_').should eq "dokument_doc"

      "/доки/dir/тест/документ".slugged_filepath(sep: '_').should      eq "/доки/dir/тест/dokument"
      "/доки/dir/тест/доку мент".slugged_filepath(sep: '_').should     eq "/доки/dir/тест/doku_ment"
      "/доки/dir/тест/доку мент".slugged_filename(sep: '_').should eq "doku_ment"
    end
  end

  context "spec chars" do
    it "should works" do
      "[$&+,:;=?@Hello world!#|'<>.^*()%!-]".to_slug_param.should eq 'hello-world'
    end

    it "should works" do
      "教師 — the-teacher".to_slug_param.should eq 'the-teacher'
      "Hello ^, I'm here!".to_slug_param.should eq 'hello-i-m-here'
    end

    it "should works" do
      "HELLO---WorlD".to_slug_param(sep: '_').should eq 'hello_world'
    end

    it "should works" do
      str = "__...HELLO-___--+++--WorlD----__&&***...__.---"
      
      str.to_slug_param.should eq 'hello-world'
      str.to_slug_param(sep: '_').should eq 'hello_world'
      str.to_slug_param(sep: '+').should eq 'hello+world'
    end

    it "should works" do
      str = "Ilya zykin aka   Killich, $$$ aka the-teacher"
      str.to_slug_param(sep: '+').should eq "ilya+zykin+aka+killich+aka+the+teacher"
    end

    it "should works" do
      str = "Илья Николаевич, прекратите кодить по выходным!".to_sym
      str.to_slug_param.should eq "ilya-nikolaevich-prekratite-kodit-po-vyhodnym"
    end
  end

  context 'Scopes' do
    it "should work with Nested Controller Name" do
      class PagesController < ApplicationController; end
      ctrl = PagesController.new
      ctrl.controller_path.to_slug_param.should eq 'pages'
    end

    it "should work with Nested Controller Name" do
      module Admin; end
      class Admin::PagesController < ApplicationController; end
      ctrl = Admin::PagesController.new
      ctrl.controller_path.to_slug_param.should eq 'admin-pages'
    end

    it "should work with Nested Controller Name" do
      module Admin; end
      class Admin::PagesController < ApplicationController; end
      ctrl = Admin::PagesController.new
      params = { sep: '_' }
      ctrl.controller_path.to_slug_param(params).should eq 'admin_pages'
    end
  end
end