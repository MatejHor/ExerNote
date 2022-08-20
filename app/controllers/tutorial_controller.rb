class TutorialController < ApplicationController
  def work_with_session
    # set
    session[:object_attribute] = 'object_attribute'
    # get
    object_attribute = session[:object_attribute]
  end

  def routes
    # Simple routes
    # (get|post|delete|patch) '/path' => 'controller#method'
    # get '/path/:id' => 'controller#method'
  end

  def create_mailer
    # Generate mailer, views, test
    # rails g mailer <mailer-name> <method>
  end

  def create_full_resources
    # Generate controller, model, db migration, update routes, helpers
    # rails g resource <resource-name> <attributes>
  end

  def helper
    # helpers contain method which we can use in any view
  end

  def change_db
    # To change db we must use following command
    # rails db:system:change --to=postgresql
    # rails db:system:change --to=mysql
    # rails db:system:change --to=sqlite3
    # rails db:system:change --to=oracle
    # rails db:system:change --to=frontbase
    # rails db:system:change --to=sqlserver
    # rails db:system:change --to=jdbc
  end

  def test
    # To run test
    # rake test
  end

  def heroku
    # Create heroku
    # heroku create <application_name> --stack heroku-18

    # Push heroku from git
    # git push heroku master

    # See heroku logs
    # heroku logs --tail

    # Open heroku app
    # heroku open

    # Open environment on heroku
    # heroku config:set Key=value

    # Run heroku rails console
    # heroku run rails console

    # Open database from heroku
    # heroku pg:psql

    # Info about db
    # heroku pg:info

    # Add css into production
    # heroku run rake assets:precompile RAILS_ENV=production

    # Create backup in heroku
    # heroku pg:backups:capture

    # Download backup from heroku
    # heroku pg:backups:download

    # Get data into database
    # pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d exernote_production latest.dump.20220820

    # Create backup from local db
    # PGPASSWORD=postgres pg_dump -h localhost -U postgres exernote_development --no-owner --no-acl -f database.dump

    # Insert data into heroku
    # heroku pg:psql DATABASE_URL --app exernote < database.dump
  end

end
