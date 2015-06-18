$:.unshift(File.dirname(__FILE__))

require 'sinatra'
require 'rubygems'
require 'bundler'
require 'logger'
Bundler.require
require 'app'
run App
