open Map\ Distance.xcodeproj
sleep 10
xcodebuild -project Map\ Distance.xcodeproj/
osascript -e 'quit app "XCode"'
ios-deploy --justlaunch --bundle ./build/Release-iphoneos/Map\ Distance.app