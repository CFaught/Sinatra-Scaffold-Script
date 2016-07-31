#!/usr/bin/env ruby

class Scaffold
  @@templates = [
    "ENV['SINATRA_ENV'] ||= 'development'\n\nrequire 'bundler/setup'\nBundler.require(:default, ENV['SINATRA_ENV'])\n\nrequire './app'\n",
    "require './config/environment'\n\nrun App",
    "# A sample Gemfile\n\nsource \"https://rubygems.org\"\n\ngem 'sinatra'\ngem 'rake'\ngem 'thin'\ngem 'shotgun'\ngem 'pry'\ngem 'require_all'\n",
    "ENV[\"SINATRA_ENV\"] ||= \"development\"\n\nrequire_relative './config/environment'\n\n# Type `rake -T` on your command line to see the available rake tasks.\n\ntask :console do\n\tPry.start\nend\n",
    "class App < Sinatra::Base\n\n#Write your routes here\n\nend"
  ]
  def self.create(args=nil)
    dir_name = args
    if dir_name.nil?
      puts "No file name given"
    else
      current_dir = Dir.pwd

      # Create Directories
      Dir.mkdir("#{current_dir}/#{dir_name}")
      Dir.chdir("#{current_dir}/#{dir_name}/")

      Dir.mkdir('./models')
      Dir.mkdir('./views')
      Dir.mkdir('./config')

      Dir.mkdir('./public')
      Dir.chdir("./public/")

      Dir.mkdir('./images')
      Dir.mkdir('./javascripts')
      Dir.mkdir('./stylesheets')

      Dir.chdir("./..")

      # Create files ./config/environment.rb, config.ru, Gemfile, and Rakefile
      self.file("#{current_dir}/#{dir_name}/config/environment.rb", @@templates[0])
      self.file("#{current_dir}/#{dir_name}/config.ru", @@templates[1])
      self.file("#{current_dir}/#{dir_name}/Gemfile", @@templates[2])
      self.file("#{current_dir}/#{dir_name}/Rakefile", @@templates[3])
      self.file("#{current_dir}/#{dir_name}/app.rb", @@templates[4])
    end
  end

  def self.file(filename, content)
    file = File.new(filename, 'w')

    file.puts content

    file.close
  end
end

Scaffold.create(ARGV[0])
