

### Constants and Variables


- Cannot assign to value: 'constant' is a 'let' constant 不能赋值给常量

```
let constant = 10
var number = 10
var result = number + constant

constant = 20 // Cannot assign to value: 'constant' is a 'let' constant
number = 50
```

### Working with Text

- Binary operator '+' cannot be applied to operands of type 'String' and 'Int'
```
var bookPrice = 39
var numOfCopies = 5
var totalPrice = bookPrice * numOfCopies
// Binary operator '+' cannot be applied to operands of type 'String' and 'Int'
var totalPriceMessage = "The price of the book is $" + totalPrice
```

- You can write the code like this by converting the integer to a string:
```var totalPriceMessage = "The price of the book is $" + String(totalPrice)
```- There is an alternate way known as String Interpolations to do that. You can write the code like this to create the totalPriceMessage variable:
```var totalPriceMessage = "The price of the book is $ \(totalPrice)"
```

### Control Flow Basics

- if-else:   
```
var timeYouWakeUp = 6
if timeYouWakeUp == 6 {
    print("Cook yourself a big breakfast!")
} else {
    print("Go out for breakfast")
}

var bonus = 5000
if bonus >= 10000 {
    print("I will travel to Paris and London!")
} else if bonus >= 5000 && bonus < 10000 {
    print("I will travel to Tokyo")
} else if bonus >= 1000 && bonus < 5000 {
    print("I will travel to Bangkok")
} else {
    print("Just stay home")
}
```

- switch:    
```
var timeYouWakeUp = 6
switch timeYouWakeUp {
case 6:
    print("Cook yourself a big breakfast!")
default:
    print("Go out for breakfast")
}

var bonus = 5000
switch bonus {
case 10000...:
    print("I will travel to Paris and London!")
case 5000...9999:
    print("I will travel to Tokyo")
case 1000...4999:
    print("I will travel to Bangkok")
default:
    print("Just stay home")
}
```

- console:  
```
Cook yourself a big breakfast!
I will travel to Tokyo
```

### Understanding Arrays and Dictionaries

```
import UIKit

var bookCollection = ["Tool of Titans", "Rework", "Your Move"]

bookCollection.append("Authority")

bookCollection.count

print(bookCollection[0])
print(bookCollection[1])
print(bookCollection[2])
print(bookCollection[3])

for index in 0...3 {
    print(bookCollection[index])
}

for index in 0...bookCollection.count - 1 {
    print(bookCollection[index])
}

for book in bookCollection {
    print(book)
}

var bookCollectionDict = ["1328683788": "Tool of Titans", "0307463745": "Rework",
                          "1612060919": "Authority"]

bookCollectionDict["0307463745"]

for (key, value) in bookCollectionDict {
    print("ISBN: \(key)")
    print("Title: \(value)")
}
```


```
var emojiDict: [String: String] = ["👻": "Ghost",
                                   "💩": "Poop",
                                   "😤": "Angry",
                                   "😱": "Scream",
                                   "👾": "Alien monster"]

var wordToLookup = "👻"
var meaning = emojiDict[wordToLookup]

print(meaning) // Expression implicitly coerced from 'String?' to 'Any'

wordToLookup = "😤"
meaning  = emojiDict[wordToLookup]

print(meaning!)
```

```
Optional("Ghost")
Angry
```

### Understanding Optionals

var jobTitle: String?

jobTitle = "iOS Developer"

// Value of optional type 'String?' must be unwrapped to a value of type 'String'
//var message = "Your job title is " + jobTitle


- Forced Unwrapping  
```
if jobTitle != nil {
    let message = "Your job title is " + jobTitle!
    print(message)
}
```

- Optional Binding  
```
if let jobTitleWithValue = jobTitle {
    let message = "Your job title is " + jobTitleWithValue
    print(message)
}

if let jobTitle = jobTitle {
    let message = "Your job title is " + jobTitle
    print(message)
}
```

### Playing around with UI

```
var emojiDict: [String: String] = ["👻": "Ghost",
                                   "💩": "Poop",
                                   "😤": "Angry",
                                   "🤓": "Nerdy",
                                   "😱": "Scream",
                                   "👾": "Alien monster"]

var wordToLookup = "🤓"
var meaning = emojiDict[wordToLookup]

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
containerView.backgroundColor = UIColor.orange

let emojiLabel = UILabel(frame: CGRect(x: 95, y: 20, width: 150, height: 150))
emojiLabel.text = wordToLookup
emojiLabel.font = UIFont.systemFont(ofSize: 100.0)

containerView.addSubview(emojiLabel)

let meaningLabel = UILabel(frame: CGRect(x: 110, y: 100, width: 150, height: 150))
meaningLabel.text = meaning
meaningLabel.font = UIFont.systemFont(ofSize: 30.0)
meaningLabel.textColor = UIColor.white

containerView.addSubview(meaningLabel)
```











