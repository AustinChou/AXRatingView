test:
	xcodebuild \
		-sdk iphonesimulator \
		-workspace EZRatingViewDemo/EZRatingViewDemo.xcworkspace \
		-scheme EZRatingViewDemo \
		-configuration Debug \
		clean build \
		ONLY_ACTIVE_ARCH=NO \
		TEST_AFTER_BUILD=YES \
		GCC_PREPROCESSOR_DEFINITIONS="IS_TEST_FROM_COMMAND_LINE=1"

