# ViperTwitterClient
Twitter client app for VIPER design pattern implementation

![tw](https://user-images.githubusercontent.com/5630896/36472755-109df17e-1736-11e8-87b8-32fcaf3a1ed0.png)

## What is VIPER?
![](https://s3.amazonaws.com/ckl-website-static/wp-content/uploads/2016/04/viper_architecture-2000x720.jpg)
> Source: [iOS Project Architecture: Using VIPER](https://cheesecakelabs.com/blog/ios-project-architecture-using-viper/)

* VIPER is based on the Single Responsibility Principle
* VIPER is an application of Clean Architecture to iOS apps
* Each layer depends only on Interface (Protocol)

More detail:<br>
* [iOS Project Architecture: Using VIPER](https://cheesecakelabs.com/blog/ios-project-architecture-using-viper/)
* [Architecting iOS Apps with VIPER](https://www.objc.io/issues/13-architecture/viper/)

## How to Build
### Create your Twitter application.
1. Fork or Clone this repository.
2. Visit https://apps.twitter.com/ to create your Twitter application.
3. Click "Keys and Access Tokens" tab.

### Build APP
1. Fork or Clone this repository.
2. Run the below commands

```
bundle install --path vendor/bundle
bundle exec pod install 
```

3. Set your app's Consumer Key and Consumer Seacret to `./ViperTwitterClient/Key.plist.`
![](https://user-images.githubusercontent.com/5630896/36472375-013c1d74-1735-11e8-9c0c-37be4513c70d.png)
