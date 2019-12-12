# default target
all: help

download_carthage_sources:
	@echo "---- Downloading Carthage Sources ----"
	carthage update --platform iOS --project-directory "./ThirdParty" --no-build
	@echo "\n"

carthage_build:
	@echo "---- Building Carthage Dependencies ----"
	carthage build --platform iOS --project-directory "./ThirdParty" --cache-builds
	@echo "\n"

carthage_install: download_carthage_sources carthage_build

help:
	@echo "Targets:"
	@echo "carthage_bootstap - downloads carthage dependencies without optimizations"
	@echo "carthage_install - installs all carthage dependencies with optimization."
	@echo "help - display this message"
	@echo "\n"