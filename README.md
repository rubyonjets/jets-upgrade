# Jets Upgrade

[![Gem Version](https://badge.fury.io/rb/jets-upgrade.svg)](http://badge.fury.io/rb/jets-upgrade)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

[![BoltOps Learn Badge](https://img.boltops.com/boltops-learn/boltops-learn.png)](https://learn.boltops.com)

This is a standalone CLI tool to help with jets upgrades.

* It supports going from jets v4 and below to jets v5.

## Usage

    cd old-jets-project
    jets-upgrade go

## What It Does

Here are some of the things the tool does. It updates:

* config/application.rb: to the new inherited based style
* Rakefile: use `Jets.application.load_tasks`
* Gemfile: update to add jets v5 related gems and comment out the current ones in your Gemfile
* config/environment: update environment files to new config settings
* controllers: updates controller to use `def destroy` instead of `def delete`

## Install

    gem install jets-upgrade

## Docs

[Jets Upgrade Docs](https://rubyonjets.com/docs/extras/upgrading/)
