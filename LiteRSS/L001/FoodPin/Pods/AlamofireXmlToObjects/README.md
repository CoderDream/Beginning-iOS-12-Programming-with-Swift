# AlamofireXmlToObjects

<!---
 [![Circle CI](https://img.shields.io/circleci/project/evermeer/AlamofireXmlToObjects.svg?style=flat)](https://circleci.com/gh/evermeer/AlamofireXmlToObjects)
 -->
[![Build Status](https://travis-ci.org/evermeer/AlamofireXmlToObjects.svg?style=flat)](https://travis-ci.org/evermeer/AlamofireXmlToObjects)
[![Issues](https://img.shields.io/github/issues-raw/evermeer/AlamofireXmlToObjects.svg?style=flat)](https://github.com/evermeer/AlamofireXmlToObjects/issues)
[![Documentation](https://img.shields.io/badge/documented-100%-brightgreen.svg?style=flat)](http://cocoadocs.org/docsets/AlamofireXmlToObjects)
[![Stars](https://img.shields.io/github/stars/evermeer/AlamofireXmlToObjects.svg?style=flat)](https://github.com/evermeer/AlamofireXmlToObjects/stargazers)
[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/matteocrippa/awesome-swift#json)

[![Version](https://img.shields.io/cocoapods/v/AlamofireXmlToObjects.svg?style=flat)](http://cocoadocs.org/docsets/AlamofireXmlToObjects)
[![Language](https://img.shields.io/badge/language-swift3-f48041.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireXmlToObjects.svg?style=flat)](http://cocoadocs.org/docsets/AlamofireXmlToObjects)
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20|%20OSX%2010.9+%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)
[![License](https://img.shields.io/cocoapods/l/AlamofireXmlToObjects.svg?style=flat)](http://cocoadocs.org/docsets/AlamofireXmlToObjects)

[![Git](https://img.shields.io/badge/GitHub-evermeer-blue.svg?style=flat)](https://github.com/evermeer)
[![Twitter](https://img.shields.io/badge/twitter-@evermeer-blue.svg?style=flat)](http://twitter.com/evermeer)
[![LinkedIn](https://img.shields.io/badge/linkedin-Edwin Vermeer-blue.svg?style=flat)](http://nl.linkedin.com/in/evermeer/en)
[![Website](https://img.shields.io/badge/website-evict.nl-blue.svg?style=flat)](http://evict.nl)
[![eMail](https://img.shields.io/badge/email-edwin@evict.nl-blue.svg?style=flat)](mailto:edwin@evict.nl?SUBJECT=About AlamofireXmlToObjects)

If you have a question and don't want to create an issue, then we can [![Join the chat at https://gitter.im/evermeer/EVReflection](https://badges.gitter.im/evermeer/EVReflection.svg)](https://gitter.im/evermeer/EVReflection?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) (EVReflection is the base of AlamofireJsonToObjects)

With AlamofireXmlToObjects it's extremely easy to fetch a XML feed and parse it into objects. No property mapping is required. Reflection is used to put the values in the corresponding properties.

AlamofireXmlToObjects is based on the folowing libraries:
- [Alamofire](https://github.com/Alamofire/Alamofire) is an elegant HTTP Networking library in Swift
- [XMLDictionary](https://github.com/nicklockwood/XMLDictionary) Is a simple way to parse and generate XML. Converts an XML file to an NSDictionary
- [EVReflection](https://github.com/evermeer/EVReflection) is used to parse the XML result to your objects

If you have a JSON service and want the same functionality then have a look at [AlamofireJsonToObjects](https://github.com/evermeer/AlamofireJsonToObjects).

At this moment the master branch is for Swift3. If you want to continue using Swift 2.2 (or 2.3) then switch to the Swift2.2 branch.
Run the tests to see AlamofireXmlToObjects in action.

## Using AlamofireXmlToObjects in your own App 

'AlamofireXmlToObjects' is available through the dependency manager [CocoaPods](http://cocoapods.org). 

You can just add AlamofireXmlToObjects to your workspace by adding the folowing 2 lines to your Podfile:

```
use_frameworks!
pod "AlamofireXmlToObjects"
```

You also have to add an import at the top of your swift file like this:

```
import AlamofireXmlToObjects
```

## Sample code

```
class WeatherResponse: EVObject {
    var location: String?
    var three_day_forecast: [Forecast] = [Forecast]()
}

class Forecast: EVObject {
    var day: String?
    var temperature: NSNumber?
    var conditions: String?
}

class AlamofireXmlToObjectsTests {
    func testResponseObject() {
        let URL = "https://raw.githubusercontent.com/evermeer/AlamofireXmlToObjects/master/AlamofireXmlToObjectsTests/sample_xml"
        Alamofire.request(.GET, URL, parameters: nil)
        .responseObject { (response: Result< WeatherResponse, NSError>) in
            if let result = response.value {
               // That was all... You now have a WeatherResponse object with data
            }
        }
    }
}

```

The code above will parse the folowing XML into the objects:

```
<wheather>
   <location>Toronto, Canada</location>
   <three_day_forecast>
      <forecast>
         <conditions>Partly cloudy</conditions>
         <day>Monday</day>
         <temperature>20</temperature>
      </forecast>
      <forecast>
         <conditions>Showers</conditions>
         <day>Tuesday</day>
         <temperature>22</temperature>
      </forecast>
      <forecast>
         <conditions>Sunny</conditions>
         <day>Wednesday</day>
         <temperature>28</temperature>
      </forecast>
   </three_day_forecast>
</wheather>
```

## Advanced object mapping
AlamofireJsonToObjects is based on [EVReflection](https://github.com/evermeer/EVReflection) and you can use all [EVReflection](https://github.com/evermeer/EVReflection) features like property mapping, converters, validators and key kleanup. See [EVReflection](https://github.com/evermeer/EVReflection) for more information.

## License

AlamofireXmlToObjects is available under the MIT 3 license. See the LICENSE file for more info.

## My other libraries:
Also see my other open source iOS libraries:

- [EVReflection](https://github.com/evermeer/EVReflection) - Swift library with reflection functions with support for NSCoding, Printable, Hashable, Equatable and JSON 
- [EVCloudKitDao](https://github.com/evermeer/EVCloudKitDao) - Simplified access to Apple's CloudKit
- [EVFaceTracker](https://github.com/evermeer/EVFaceTracker) - Calculate the distance and angle of your device with regards to your face in order to simulate a 3D effect
- [EVURLCache](https://github.com/evermeer/EVURLCache) - a NSURLCache subclass for handling all web requests that use NSURLReques
- [AlamofireJsonToObject](https://github.com/evermeer/AlamofireJsonToObjects) - An Alamofire extension which converts JSON response data into swift objects using EVReflection
- [AlamofireXmlToObject](https://github.com/evermeer/AlamofireXmlToObjects) - An Alamofire extension which converts XML response data into swift objects using EVReflection and XMLDictionary
- [AlamofireOauth2](https://github.com/evermeer/AlamofireOauth2) - A swift implementation of OAuth2 using Alamofire
- [EVWordPressAPI](https://github.com/evermeer/EVWordPressAPI) - Swift Implementation of the WordPress (Jetpack) API using AlamofireOauth2, AlomofireXmlToObjects and EVReflection (work in progress)
- [PassportScanner](https://github.com/evermeer/PassportScanner) - Scan the MRZ code of a passport and extract the firstname, lastname, passport number, nationality, date of birth, expiration date and personal numer.
