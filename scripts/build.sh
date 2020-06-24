#!/bin/bash

echo "Building iOS binary..."

flutter build ios --release --flavor production -t lib/main-production.dart

cd ios

xcodebuild -workspace Runner.xcworkspace -scheme Runner -sdk iphoneos -configuration Release archive -archivePath $PWD/build/Runner.xcarchive

xcodebuild -allowProvisioningUpdates -exportArchive -archivePath $PWD/build/Runner.xcarchive -exportOptionsPlist exportOptions.plist -exportPath $PWD/build/Runner.ipa

echo "Done."
