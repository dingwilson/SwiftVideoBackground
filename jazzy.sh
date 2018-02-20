#!/bin/bash

# if [[ "${TRAVIS_PULL_REQUEST}" == "false" ]] && [[ "${TRAVIS_BRANCH}" == "master" ]]; then

	echo -e "Generating docs... \n"

	# Set git config email and name
	git config --global user.email "travis@travis-ci.org"
	git config --global user.name "Travis-CI"

	# ensure we are on master
	git checkout -b test

	# install jazzy
	gem install jazzy

	# remove existing docs
	rm -rf docs/

	# run jazzy with .jazzy.yml
	jazzy --config .jazzy.yml

	# git add, commit, push to master
	git add docs/
	git commit -m "Regen jazzy docs [ci skip]"
	git remote add origin https://${GH_Token}@github.com/dingwilson/SwiftVideoBackground.git > /dev/null 2>&1
	git push origin test > /dev/null 2>&1

	echo -e "Successfully published latest docs.\n"

# fi