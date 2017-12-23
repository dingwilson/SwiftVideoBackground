all: 

docs:
	rm -rf docs
	jazzy --config .jazzy.yml
	cp -r Assets docs/