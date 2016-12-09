# QBSubscriberField

QBSubscriberField

Version License Platform

Overview

QBSubscriberField is a subclass of UITextField, written in Swift, that enables the UITextField to accept the E-mail of a subscriber along with submit button.



Requirements

ARC
iOS8
Installation with CocoaPods

QBSubscriberField is available through CocoaPods. To install it, simply add the following line to your Podfile:

pod "QBSubscriberField"
Usage

import QBSubscriberField

let sampleTextField = QBSubscriberField(frame: CGRect(x: x.origin, y: y.origin, width: widthOfField , height: 40.00));
self.view.addSubview(sampleTextField)

Example Project

An example project is included with this repo. To run the example project, clone the repo, and run pod install from the Example directory first.

Author

Andy Obusek

License

QBSubscriberField is available under the MIT license. See the LICENSE file for more info.
