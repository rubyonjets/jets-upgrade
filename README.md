# Jets Upgrade

[![Gem Version](https://badge.fury.io/rb/jets-upgrade.svg)](http://badge.fury.io/rb/jets-upgrade)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

[![BoltOps Learn Badge](https://img.boltops.com/boltops-learn/boltops-learn.png)](https://learn.boltops.com)

This is a standalone CLI tool to help with jets upgrades.

* It can handle going from Jets v3 or v4 to Jets v5.

## Usage

    cd old-jets-project
    jets-upgrade go

Before proceeding, the tool will prompt you with a "Are you sure" message.

## What It Does

Here are some of the things the tool does. It updates:

* config/application.rb: to the new inherited based style
* Rakefile: use `Jets.application.load_tasks`
* Gemfile: update to add jets v5 related gems and comment out the current ones in your Gemfile
* config/environment: update environment files to new config settings
* controllers: updates controller to use `def destroy` instead of `def delete`

## Important

It's unfeasible to account for all cases and Jets apps. This script cannot perform miracle upgrades. It's a best-effort script, and the hope is that this script gets you pretty far and is helpful. 😄

Also see: [Jets 5 Upgrading Notes](https://docs.rubyonjets.com/docs/extras/upgrading/jets-5/)

## Install

    gem install jets-upgrade

## Javascript Option

By default, the `jets-upgrade go` command also tries to upgrade JavaScript. Jets v5 goes from webpacker to importmap. So, the node-related files are no longer needed. The upgrade command will remove node-related files. If you do not want this behavior, use the `--no-javascript` option.

## Docs

[Jets Upgrade Docs](https://rubyonjets.com/docs/extras/upgrading/)
