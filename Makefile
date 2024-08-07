# Note: hacked this together, need to clean it up ...

BINARIES_DIRECTORY=/usr/local/bin/
EXECUTABLE_NAME=gitfame
BUILD_PATH=.build/release/
EXECUTABLE_PATH=$(BINARIES_DIRECTORY)$(EXECUTABLE_NAME)

install:
	swift build -c release
	cp -rf $(BUILD_PATH)/$(EXECUTABLE_NAME) $(EXECUTABLE_PATH)

uninstall:
	rm -f $(BINARIES_DIRECTORY)$(EXECUTABLE_NAME)
