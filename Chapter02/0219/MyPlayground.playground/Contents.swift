import UIKit

var jobTitle: String?

jobTitle = "iOS Developer"

// Value of optional type 'String?' must be unwrapped to a value of type 'String'
//var message = "Your job title is " + jobTitle


// Forced Unwrapping
if jobTitle != nil {
    let message = "Your job title is " + jobTitle!
    print(message)
}

// Optional Binding
if let jobTitleWithValue = jobTitle {
    let message = "Your job title is " + jobTitleWithValue
    print(message)
}

if let jobTitle = jobTitle {
    let message = "Your job title is " + jobTitle
    print(message)
}
