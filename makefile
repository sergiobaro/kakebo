.PHONY: pods

coverage:
	bundle exec slather coverage --html --show

mocks:
	swiftymocky generate

pods:
	bundle exec pod install
