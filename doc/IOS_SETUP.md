# iOS Specific Setup

#### Firebase Auth

###### Google Auth Provider

1. In [Info.plist](../ios/Runner/Info.plist) add beloew lines

```xml
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.102730474815-ve7fo2q41gvb81nq6m0vukop4i2vm1hq</string>
        </array>
    </dict>
</array>
```

2. In [Podfile](../ios/Podfile), uncomment the link `platform :ios, '13.0'`
