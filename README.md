TTCounterLabel
==============
A custom UILabel that acts as a time counter, counting up or down and formatting the string to hours, minutes, seconds and milliseconds. Designed to accept a value in milliseconds that is then displayed it in a time friendly format. Currently the controls supports up-to a maximum value of 99 hours 59 minutes 59 seconds and 999 milliseconds, which should be enough for most uses. The control automatically removes any leading zeros and centralises the result. It also supports different fonts for each unit division.

![Alt text](/screenshot.PNG "TTCounterLabel")

Setup
-----

**Installing with [CocoaPods](http://cocoapods.org)**

If you're unfamiliar with CocoaPods there is a great tutorial [here](http://www.raywenderlich.com/12139/introduction-to-cocoapods) to get you up to speed.

1. In Terminal navigate to the root of your project.
2. Run 'touch Podfile' to create the Podfile.
3. Open the Podfile using 'open -e Podfile'
4. Add the pod `TTCounterLabel` to your [Podfile](https://github.com/CocoaPods/CocoaPods/wiki/A-Podfile).

        platform :ios
        pod 'TTCounterLabel'
        
5. Run `pod install`.
6. Open your app's `.xcworkspace` file to launch Xcode and start using the control!

**Installing manually from GitHub**

1.  Download the `TTCounterLabel.h` and `TTcounterLabel.m` files and add them to your Xcode project.
2.  `#import TTCounterLabel.h` wherever you need it.
3.  Follow the included sample project to get started.

**Running the sample project**

Check out the [sample project](https://github.com/TriggerTrap/TTCounterLabel/tree/master/Sample) included in the repository. Just open the '.xcworkspace' file in the Sample folder and the project should build correctly.

Usage
-----

1. Add a normal Label control to your storyboard
2. In the Identity Inspector for the label, set the Custom Class to TTCounterLabel
3. Implement the TTCounterLabelDelegate interface to receive callbacks from the label
4. Set the label's countDirection to one of kCountDirectionDown or kCountDirectionUp
5. call [label setStartValue:&lt;time in ms>] to set the start value (important in the case of a downward counter).
6. Use [label start] and [label stop] to start and stop the counter.
7. The counter calls back on the contdownDidEnd method on the class that implements TTCounterLabelDelegate. The source parameter will be a reference to the label object that fired the event.

Author(s)
-------

[Triggertrap Limited](https://github.com/TriggerTrap)

[Ross Gibson](https://github.com/Ross-Gibson)

Licence
-------

Distributed under the MIT License.
