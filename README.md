# TutorialSinatra

This tutorial will step through a simple Sinatra Ruby app, with each commit adding features and functionality. So start from the first commit and then checkout each commit to see the progress. Notes will be added to this README file as we go along.

## Step 1

- Install Linux for Windows (WSL VERSION 2!) https://docs.microsoft.com/en-us/windows/wsl/install-win10
- Then download Ubuntu 20.04 LTS from Windows Store https://www.microsoft.com/store/productId/9N6SVWS3RX71

So now you have Ubuntu Linux running on Windows. Double-clicking on the Ubuntu icon will put you "inside" the Ubuntu virtual machine, so its kind of "seperate" from Windows. When Googling for help, anything about Ubuntu should work.

- Download Windows Terminal https://www.microsoft.com/store/productId/9N0DX20HK701

When you run Windows Terminal, use the arrow drop down to select Ubuntu

- Inside Ubuntu, run these commands:

```
  sudo apt update
  sudo apt upgrade -y
  sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  exec $SHELL

  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
  exec $SHELL

  rbenv install 2.7.2
  rbenv global 2.7.2

  ruby -v
```

Ruby uses "gems" to package and distribute code. To see a list of installed gems, `gem list` or `gem info` for more detail. If you `gem install whatever` it will install the code into the global gem list. But each project you are working on can also have its own private gem list, which is a best practice. So for this we use `bundler`.

Bundler works by having a file called Gemfile in a directory, which you then declare what gems you want to use, and run bundle to install them. Go to the next commit to see this happen.

## Step 2

OK so we added a Gemfile, added the Sinatra gem, and ran `bundle`, which installed the code and created a Gemfile.lock file, which specifies the exact versions used. At any time you can delete the Gemfile.lock and re-run bundle to get the latest versions of everything.
