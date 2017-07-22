Compile flags (cofl)
===================

[![Swift Version](https://img.shields.io/badge/Swift-3.1-orange.svg)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](https://www.apple.com/ru/ios)
[![License](https://img.shields.io/badge/license-MIT-yellow.svg)](https://github.com/artFintch/VideoMerger/blob/master/LICENSE)

It's a tiny utility for managing compile flags of source files in Xcode project. Can be helpful when you need to generate Xcode Project (e.g. with [qmake](http://doc.qt.io/qt-5/qmake-manual.html)).

## Installation
Need to add library [XcodeEditor](https://github.com/appsquickly/XcodeEditor) in Target Dependencies of Xcode Project.

#### Usage:
```
Usage: cofl [options]
  -p, --project:
      Path to the project file.
  -f, --flag:
      Compile flags without -.
  -s, --sources:
      Source files.
  -h, --help:
      Prints a help message.
```

#### Example:
```bash
cofl -p MyGameProject.xcodeproj \
-f fvisibility=default \
-s SoundController.m GameViewController.m GameScene.m

----------------------------------
File path: MyGameProject.xcodeproj
Compiler flags:
	* -fvisibility=default
Source files:
	* SoundController.m
	* GameViewController.m
	* GameScene.m
-----------------------------------
```

## License
Cofl is released under the MIT license. [See LICENSE](https://github.com/artFintch/Cofl/blob/master/LICENSE) for details.
