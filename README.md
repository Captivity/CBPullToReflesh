<p align="center">  <img src="https://d13yacurqjgara.cloudfront.net/users/141880/screenshots/2542648/dailyui-094.gif" width="700" height="500"/>
</p>

# CBPullToReflesh

[![Cbangchen](https://img.shields.io/badge/cbangchen-iOS-yellow.svg)](http://cbangchen.com) 
[![Version](https://img.shields.io/cocoapods/v/CBPullToReflesh.svg?style=flat)](http://cocoapods.org/pods/CBPullToReflesh) 
[![License](https://img.shields.io/cocoapods/l/CBPullToReflesh.svg?style=flat)](http://cocoapods.org/pods/CBPullToReflesh) 
[![Platform](https://img.shields.io/cocoapods/p/CBPullToReflesh.svg?style=flat)](http://cocoapods.org/pods/CBPullToReflesh) 

> **Dribbble**网址：[Daily-UI-094-News](https://dribbble.com/shots/2542648-Daily-UI-094-News)，点击 [此处](http://cbangchen.com/notes/%E4%B8%8B%E6%8B%89%E5%88%B7%E6%96%B0%E4%B9%9F%E5%8F%AF%E4%BB%A5%E5%BE%88%E7%BE%8E) 查看详细教程

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


