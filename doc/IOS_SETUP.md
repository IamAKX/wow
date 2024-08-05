# iOS Specific Setup

#### Firebase Auth

###### Google and Facebook Auth Provider

1. In [Info.plist](../ios/Runner/Info.plist) add beloew lines

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.102730474815-ve7fo2q41gvb81nq6m0vukop4i2vm1hq</string>
            <string>1066196318458159</string>
        </array>
    </dict>
</array>
<key>FacebookAppID</key>
<string>1066196318458159</string>
<key>FacebookClientToken</key>
<string>3529a46a6cfafb7a7841e58e1504ef2f</string>
<key>FacebookDisplayName</key>
<string>Wow's Auth</string>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fbapi</string>
    <string>fb-messenger-share-api</string>
</array>
```

2. In [Podfile](../ios/Podfile), uncomment the link `platform :ios, '13.0'`
