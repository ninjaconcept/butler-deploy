require 'rails/generators/resource_helpers'

module Butler
  module Deploy
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      class_option :app_name, banner: 'my-app-name', type: :string, required: true
      class_option :production_host, banner: 'xx.ninjaconcept.com', type: :string, required: true
      class_option :staging_host, banner: 'xx.ninjaconcept.com', type: :string, required: false

      def add_gems
        gem_group :development do
          gem 'capistrano', '~> 3.1'
          gem 'capistrano-rails', '~> 1.1'
          gem 'capistrano-bundler', '~> 1.1.2'
          gem 'capistrano-chruby', '~> 0.1.1'
        end

        bundle_install
      end

      def capify
        run 'cap install'
      end

      def use_capistrano_modules
        uncomment_lines 'Capfile', /require 'capistrano\/chruby'/
        uncomment_lines 'Capfile', /require 'capistrano\/bundler'/
        uncomment_lines 'Capfile', /require 'capistrano\/rails\/assets'/
        uncomment_lines 'Capfile', /require 'capistrano\/rails\/migrations'/
      end

      def add_butler_deploy_tasks
        append_to_file 'Capfile', "require 'capistrano/butler_deploy'"
      end

      def main_config
        gsub_file 'config/deploy.rb', /set :application, 'my_app_name'/, "set :application, '#{options['app_name']}'"
        gsub_file 'config/deploy.rb', /set :repo_url, 'git@example.com:me\/my_repo.git'/, "set :repo_url, 'git@github.com:ninjaconcept/#{options['app_name']}.git'"
        gsub_file 'config/deploy.rb', /# set :deploy_to, '\/var\/www\/my_app_name'/, "set :deploy_to, '/home/deploy/www/#{options['app_name']}'"

        uncomment_lines 'config/deploy.rb', /ask :branch/
        uncomment_lines 'config/deploy.rb', /set :linked_files/
        uncomment_lines 'config/deploy.rb', /set :linked_dirs/
      end

      def production_config
        gsub_file 'config/deploy/production.rb',
                  /# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value/,
                  "server '#{options['production_host']}', user: 'deploy', roles: %w{app db web}"
      end

      def staging_config
        if options[:staging_host]
          gsub_file 'config/deploy/staging.rb',
                    /# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value/,
                    "server '#{options['staging_host']}', user: 'deploy', roles: %w{app db web}"
        end
      end

      def add_unicorn_gem
        gem 'unicorn'

        gem_group :development do
          gem 'unicorn-rails'
        end

        bundle_install
      end

      def copy_unicorn_config
        template 'unicorn/production.rb', File.join('config', 'unicorn', 'production.rb')
        template 'unicorn/staging.rb', File.join('config', 'unicorn', 'staging.rb')
      end

      def capistrano_pending
        gem_group :development do
          gem 'capistrano-pending', require: false
        end

        append_to_file 'Capfile', "require 'capistrano-pending'"

        bundle_install
      end

      private

      def bundle_install
        run 'bundle'
      end
    end
  end
end
