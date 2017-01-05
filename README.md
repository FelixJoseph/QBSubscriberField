# QBSubscriberField

[![CI Status](http://img.shields.io/travis/Felix/QBSubscriberField.svg?style=flat)](https://travis-ci.org/Felix/QBSubscriberField)
[![Version](https://img.shields.io/cocoapods/v/QBSubscriberField.svg?style=flat)](http://cocoapods.org/pods/QBSubscriberField)
[![License](https://img.shields.io/cocoapods/l/QBSubscriberField.svg?style=flat)](http://cocoapods.org/pods/QBSubscriberField)
[![Platform](https://img.shields.io/cocoapods/p/QBSubscriberField.svg?style=flat)](http://cocoapods.org/pods/QBSubscriberField)

##Overview

QBSubscriberField is a subclass of UITextField, written in Swift, that enables the UITextField to accept the E-mail of a subscriber along with submit button.

<p align="center">
<img src="http://imgur.com/mf4kmZd.gif" alt="QBSubscriberField" />
</p>

## Highlights

- [x] Text color and background color of the text field is customizable.
- [x] Button color is customizable
- [x] The floating label will have the same color as the text color.
- [x] User can handle success and error condition.
- [x] Supports Swift and Objective-C.

## Installation

### CocoaPods:

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

QBSubscriberField is available through CocoaPods. To install it, specify it in your Podfile:

```ruby

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
pod "QBSubscriberField"
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually:

* Download QBSubscriberField.
* Drag and drop QBSubscriberField directory to your project

##Usage

import QBSubscriberField

let sampleTextField = QBSubscriberField(frame: CGRect(x: x.origin, y: y.origin, width: widthOfField , height: 40.00));
self.view.addSubview(sampleTextField)

##Example Project

An example project is included with this repo. To run the example project, clone the repo, and run pod install from the Example directory first.

## Requirements

* Xcode 7.3+
* iOS 8.0+

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Usage

Here is how you can use `QBSubscriberField`. 

Import QBSubscriberField to your viewcontroller,

```swift
import QBSubscriberField
```

* Drag and drop a UITextField in the storyboard and set its constraints and attributes like background color and title color.
* Set the text field class and module to QBSubscriberField.
* Set delegate of the button.
* In the didFinishTask delegate method do the task with the entered emailId.
* After completing the task with the entered emailId call complete function with .success or .failure argument.

```swift
import UIKit
import QBSubscriberField

class ViewController: UIViewController, SubscriberFieldDelegate {

    @IBOutlet weak var subscriberField: QBSubscriberField!

    override func viewDidLoad() {

        super.viewDidLoad()
        subscriberField.callbackDelegate = self
    }

    func didFinishTask(sender: String, field button: QBSubscriberField) {
        // do task using the email
        button.completion(result: .success)
    }
}
```
##Author

Felix Joseph, felix@qburst.com

##License

QBSubscriberField is available under the MIT license. See the LICENSE file for more info.
