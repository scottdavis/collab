# DO NOT MODIFY THIS FILE

require 'digest/sha1'
require "rubygems"

module Gem
  class Dependency
    if !instance_methods.map { |m| m.to_s }.include?("requirement")
      def requirement
        version_requirements
      end
    end
  end
end

module Bundler
  module SharedHelpers

    def default_gemfile
      gemfile = find_gemfile
      gemfile or raise GemfileNotFound, "The default Gemfile was not found"
      Pathname.new(gemfile)
    end

    def in_bundle?
      find_gemfile
    end

  private

    def find_gemfile
      return ENV['BUNDLE_GEMFILE'] if ENV['BUNDLE_GEMFILE']

      previous = nil
      current  = File.expand_path(Dir.pwd)

      until !File.directory?(current) || current == previous
        filename = File.join(current, 'Gemfile')
        return filename if File.file?(filename)
        current, previous = File.expand_path("..", current), current
      end
    end

    def clean_load_path
      # handle 1.9 where system gems are always on the load path
      if defined?(::Gem)
        me = File.expand_path("../../", __FILE__)
        $LOAD_PATH.reject! do |p|
          next if File.expand_path(p).include?(me)
          p != File.dirname(__FILE__) &&
            Gem.path.any? { |gp| p.include?(gp) }
        end
        $LOAD_PATH.uniq!
      end
    end

    def reverse_rubygems_kernel_mixin
      # Disable rubygems' gem activation system
      ::Kernel.class_eval do
        if private_method_defined?(:gem_original_require)
          alias rubygems_require require
          alias require gem_original_require
        end

        undef gem
      end
    end

    def cripple_rubygems(specs)
      reverse_rubygems_kernel_mixin

      executables = specs.map { |s| s.executables }.flatten

     :: Kernel.class_eval do
        private
        def gem(*) ; end
      end
      Gem.source_index # ensure RubyGems is fully loaded

      ::Kernel.send(:define_method, :gem) do |dep, *reqs|
        if executables.include? File.basename(caller.first.split(':').first)
          return
        end
        opts = reqs.last.is_a?(Hash) ? reqs.pop : {}

        unless dep.respond_to?(:name) && dep.respond_to?(:requirement)
          dep = Gem::Dependency.new(dep, reqs)
        end

        spec = specs.find  { |s| s.name == dep.name }

        if spec.nil?
          e = Gem::LoadError.new "#{dep.name} is not part of the bundle. Add it to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        elsif dep !~ spec
          e = Gem::LoadError.new "can't activate #{dep}, already activated #{spec.full_name}. " \
                                 "Make sure all dependencies are added to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        end

        true
      end

      # === Following hacks are to improve on the generated bin wrappers ===

      # Yeah, talk about a hack
      source_index_class = (class << Gem::SourceIndex ; self ; end)
      source_index_class.send(:define_method, :from_gems_in) do |*args|
        source_index = Gem::SourceIndex.new
        source_index.spec_dirs = *args
        source_index.add_specs(*specs)
        source_index
      end

      # OMG more hacks
      gem_class = (class << Gem ; self ; end)
      gem_class.send(:define_method, :bin_path) do |name, *args|
        exec_name, *reqs = args

        spec = nil

        if exec_name
          spec = specs.find { |s| s.executables.include?(exec_name) }
          spec or raise Gem::Exception, "can't find executable #{exec_name}"
        else
          spec = specs.find  { |s| s.name == name }
          exec_name = spec.default_executable or raise Gem::Exception, "no default executable for #{spec.full_name}"
        end

        File.join(spec.full_gem_path, spec.bindir, exec_name)
      end
    end

    extend self
  end
end

module Bundler
  LOCKED_BY    = '0.9.11'
  FINGERPRINT  = "bc067d01abbb21b054cfc123f404a7874dfc8f94"
  AUTOREQUIRES = {:test=>[["faker", false], ["shoulda", false], ["factory_girl", false]], :default=>[["mysql", false], ["formtastic", false], ["paperclip", false], ["will_paginate", false], ["clearance", false]], :development=>[["mongrel", false]], :developemtn=>[["faker", false]]}
  SPECS        = [
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/faker-0.3.1.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/faker-0.3.1/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/mongrel-1.1.5.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/mongrel-1.1.5/lib", "/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/mongrel-1.1.5/ext"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/fastthread-1.0.7.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/fastthread-1.0.7/lib", "/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/fastthread-1.0.7/ext"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/mysql-2.8.1.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/mysql-2.8.1/lib", "/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/mysql-2.8.1/ext"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/shoulda-2.10.3.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/shoulda-2.10.3/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/formtastic-0.9.7.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/formtastic-0.9.7/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/rack-1.0.1.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/rack-1.0.1/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/gem_plugin-0.2.3.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/gem_plugin-0.2.3/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/cgi_multipart_eof_fix-2.5.0.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/cgi_multipart_eof_fix-2.5.0/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/paperclip-2.3.1.1.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/paperclip-2.3.1.1/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/will_paginate-2.3.12.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/will_paginate-2.3.12/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/factory_girl-1.2.3.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/factory_girl-1.2.3/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/actionpack-2.3.5.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/actionpack-2.3.5/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/daemons-1.0.10.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/daemons-1.0.10/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/clearance-0.8.8.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/clearance-0.8.8/lib"]},
        {:loaded_from=>"/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/specifications/activesupport-2.3.5.gemspec", :load_paths=>["/Users/sdavis/.rvm/gems/ruby-1.8.7-p249/gems/activesupport-2.3.5/lib"]},
      ].map do |hash|
    spec = eval(File.read(hash[:loaded_from]), binding, hash[:loaded_from])
    spec.loaded_from = hash[:loaded_from]
    spec.require_paths = hash[:load_paths]
    spec
  end

  extend SharedHelpers

  def self.match_fingerprint
    print = Digest::SHA1.hexdigest(File.read(File.expand_path('../../Gemfile', __FILE__)))
    unless print == FINGERPRINT
      abort 'Gemfile changed since you last locked. Please `bundle lock` to relock.'
    end
  end

  def self.setup(*groups)
    match_fingerprint
    clean_load_path
    cripple_rubygems(SPECS)
    SPECS.each do |spec|
      Gem.loaded_specs[spec.name] = spec
      $LOAD_PATH.unshift(*spec.require_paths)
    end
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      (AUTOREQUIRES[group.to_sym] || []).each do |file, explicit|
        if explicit
          Kernel.require file
        else
          begin
            Kernel.require file
          rescue LoadError
          end
        end
      end
    end
  end

  # Setup bundle when it's required.
  setup
end
