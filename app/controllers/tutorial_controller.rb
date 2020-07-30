class TutorialController < ApplicationController
  def work_with_session
    # set
    session[:object_attribute] = 'object_attribute'
    # get
    object_attribute = session[:object_attribute]
  end

  def create_mailer
    # rails g mailer <mailer-name> <method>
    # generate mailer, views, test
  end

  def create_full_resources
    # rails g resource <resource-name> <attributes>
    # generate controller, model, db migration, update routes, helpers
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
    # to run test
    # rake test
  end

  def heroku
    # Create heroku
    # heroku create

    # Push heroku from git
    # git push heroku master

    # See heroku logs
    # heroku logs --tail

    # Open heroku app
    # heroku open

    # Open enviroment on heroku
    # heroku config:set Key=value

    # Run heroku rails console
    # heroku run rails console

    # Open database from heroku
    # heroku pg:psql

    # Info about db
    # heroku pg:info
  end

end
