import UIKit

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
