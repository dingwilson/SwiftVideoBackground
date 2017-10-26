all: 

docs:
	rm -rf docs
	jazzy --clean --author com.wilsonding --author_url http://wilsonding.com --github_url https://github.com/dingwilson/SwiftVideoBackground --output docs
