<p align="center">  <img src="https://d13yacurqjgara.cloudfront.net/users/141880/screenshots/2542648/dailyui-094.gif" width="700" height="500"/>
</p>

# CBPullToReflesh

[![Cbangchen](https://img.shields.io/badge/cbangchen-iOS-yellow.svg)](http://cbangchen.com) 
[![Version](https://img.shields.io/cocoapods/v/CBPullToReflesh.svg?style=flat)](http://cocoapods.org/pods/CBPullToReflesh) 
[![License](https://img.shields.io/cocoapods/l/CBPullToReflesh.svg?style=flat)](http://cocoapods.org/pods/CBPullToReflesh) 
[![Platform](https://img.shields.io/cocoapods/p/CBPullToReflesh.svg?style=flat)](http://cocoapods.org/pods/CBPullToReflesh) 

> **Dribbble**网址：[Daily-UI-094-News](https://dribbble.com/shots/2542648-Daily-UI-094-News)

## Requirements 

- Swift 3.0
- iOS 8.0

## Installation 

CBPullToReflesh is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CBPullToReflesh"
``` 

Don't forget to specify you Swift version. 

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
``` 

## Usage

### Wrap your scrollView

``` Objective-C
let tableViewWrapper = PullToRefleshView(scrollView: yourTableView)
bodyView.addSubview(tableViewWrapper)
```

The color of the wrapper will be same as your scrollView's background color.


### Handler

``` Objective-C
tableViewWrapper.didPullToRefresh = {
   //...
}

```

End the reflesh simplily 

```Objective-C
 tableViewWrapper.endReflesh()
```


