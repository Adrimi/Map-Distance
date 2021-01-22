xcodebuild clean -project BitbarIOSSample.xcodeproj -configuration Release -alltargets
xcodebuild archive -project BitbarIOSSample.xcodeproj -scheme BitbarIOSSample-cal -archivePath BitbarIOSSample.xcarchive

xcodebuild -exportArchive -archivePath BitbarIOSSample.xcarchive -exportPath BitbarIOSSample-cal -exportFormat ipa -exportProvisioningProfile "iOSTeam Provisioning Profile: *"