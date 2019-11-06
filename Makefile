# default target
all: help

download_carthage_sources:
	@echo "---- Downloading Carthage Sources ----"
	carthage update --platform iOS --project-directory "./ThirdParty" --no-build
	@echo "\n"

optimize_networking:
	@echo "---- Optimizing *Networking* ----"
	sed -i -e 's/MACH_O_TYPE = mh_dylib/MACH_O_TYPE = staticlib/g' ThirdParty/Carthage/Checkouts/Networking/Networking.xcodeproj/project.pbxproj
	@echo "\n"

optimize_caching:
	@echo "---- Optimizing *Caching* ----"
	sed -i -e 's/MACH_O_TYPE = mh_dylib/MACH_O_TYPE = staticlib/g' ThirdParty/Carthage/Checkouts/Caching/Caching.xcodeproj/project.pbxproj
	@echo "\n"

carthage_build:
	@echo "---- Building Carthage Dependencies ----"
	carthage build --platform iOS --project-directory "./ThirdParty" --cache-builds
	@echo "\n"

carthage_install: download_carthage_sources optimize_networking optimize_caching carthage_build

help:
	@echo "Targets:"
	@echo "carthage_bootstap - downloads carthage dependencies without optimizations"
	@echo "optimize_networking - optimizes *Networking* to be a used as a *staticlib*"
	@echo "optimize_caching - optimizes *Caching* to be a used as a *staticlib*"
	@echo "carthage_install - installs all carthage dependencies with optimization."
	@echo "help - display this message"
	@echo "\n"