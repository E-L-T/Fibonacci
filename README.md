# Fibonacci

Fibonacci is a recruitment exercise for Enercoop. The goal is quite simple, we have here a sample app with a very basic login, your job is to improve the sign up form. Good luck !

# How to take the test ?

- Clone this repo (do not fork it),
- When you are ready, send via email either your github project link or your zipped directory. Do not forget to attach your .git folder :)

# Install

First of all, you need to install docker-compose : https://docs.docker.com/compose/install/

Once you have docker-compose installed and running, use the `docker-compose up` command at the root of your project to install and launch :

* A postgresql container named *db*
* A rails container named *web*
* A rubocop/guard container named *rubocop*

Then you need to create your database by running :

```
$ docker-compose run web rake db:create
$ docker-compose run web rake db:migrate
```

You should now be able to go to `http://localhost:3000` and start coding !

Oh ! By the way, if you are not familiar with Docker and fail to run your classic `rails` commands, it is probably because you're not specifying the Docker container in wich to run them. As a general rule, you may want to prefix all your commands by `docker-compose run web [your_command]`. Or, you could launch a bash in the 'web' container and run your commands from there : `docker-compose run web /bin/bash`.

> Note 1 : if you're using Linux, you may encounter a common DNS problem. You will know if the build fails during the `apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs` command. Solve this by doing :
> * Find your DNS IP : `nmcli device show | grep IP4.DNS`
> * Open the docker config file : `sudo vim /etc/default/docker`
> * Add your DNS : `DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 --dns [your_dns]"`
> * Open the docker service file : `sudo vim /lib/systemd/system/docker.service`
> * Replace the ExecStart line with your DNS : `ExecStart=/usr/bin/dockerd --dns [your_dns] --dns 8.8.8.8 --dns 8.8.4.4 -H fd://`
> * Restart docker :
> ```
> $ sudo service docker stop
> $ systemctl daemon-reload
> $ sudo service docker start
> ```
>
> Then you need to create your database by running :
>
> ```
> $ docker-compose run web rake db:create
> $ docker-compose run web rake db:migrate
> ```
>
> You should now be able to go to `http://localhost:3000` and start coding ! If you want to stop coding, you can stop the application with `Ctrl-C`, or with `docker-compose down`.


> Note 2 : if you're stopping the application with `Ctrl-C`, and attempt to restart it, you might get the following error:
> ```
> web_1 | A server is already running. Check /myapp/tmp/pids/server.pid.
> ```
> To solve this, delete the file `tmp/pids/server.pid` and re-start the application with `docker-compose up`.

For more complete infos on how to use Docker with Rails, you can read the quikstart guide [here](https://docs.docker.com/compose/rails/).

# What is there ?

The app you've just installed has already some features. Let's see that from the Gemfile perspective ...

```ruby
# Use Slim for views
gem 'slim', '~> 3.0.6'

# Use Clearance for authentication & authorization with email & password
gem 'clearance', '~> 1.16'

# SimpleForm made forms easy!
gem 'simple_form', '~> 3.5'

# Bootstrap for style
gem 'bootstrap', '~> 4.0.0.beta'

# AASM is a continuation of the acts-as-state-machine rails plugin, built for plain Ruby objects
gem 'aasm', '~> 4.12', '>= 4.12.2'

group :development, :test do
  # Rubocop is a Ruby code style checking tool
  gem 'guard', '~> 2.14', '>= 2.14.1'
  gem 'guard-rubocop', '~> 1.3'
end
```

If you are not familiar with these gems, you can read the docs :

* [Slim](http://slim-lang.com/)
* [Clearance](https://github.com/thoughtbot/clearance)
* [Simple Form](https://github.com/plataformatec/simple_form)
* [Bootstrap](https://getbootstrap.com/docs/4.0/getting-started/introduction/)
* [AASM](https://github.com/aasm/aasm)
* [Rubocop](https://github.com/bbatsov/rubocop) (see our config file [here](https://github.com/enercoop/Fibonacci/blob/master/.rubocop.yml))

# Exercise

As we said earlier, your goal is to improve our sign up form.

If you go to `http://localhost:3000/`, you should see our home page :

![](https://raw.githubusercontent.com/enercoop/Fibonacci/master/public/readme/home.png)

Here, you should be able to click on the 'Sign up !' button, and go to the sign up page :

![](https://raw.githubusercontent.com/enercoop/Fibonacci/master/public/readme/signup.png)

This is where you step in. We want you to update this very simple form into a two steps form that should look like this :

![](https://raw.githubusercontent.com/enercoop/Fibonacci/master/public/readme/sign_up_1of2.png)

![](https://raw.githubusercontent.com/enercoop/Fibonacci/master/public/readme/sign_up_2of2.png)

We will not tell you strong rules about how to make the form, and what it should do, just make it as good as you can. But if you don't know how to start, here are a few guidelines you can follow :

* Set up field validations
* Use a state machine (AASM) for the multi-step form
* Allow the user to go back to step one
* Use the [rectify gem](https://github.com/andypike/rectify) to dry some code
* Check your syntax using rubocop
* Maybe send a welcome mail using a background job
* Maybe install rspec, export the Clearance feature specs (`rails generate clearance:specs`) and update them
* Maybe allow the user to close its browser, then come back and recover his session

Now that you have done all of that, you can sign up, and if you did it well, you should see our dashboard page :

![](https://raw.githubusercontent.com/enercoop/Fibonacci/master/public/readme/done.png)
