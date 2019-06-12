import UIKit

var bookPrice = 39
var numOfCopies = 5
var totalPrice = bookPrice * numOfCopies
// Binary operator '+' cannot be applied to operands of type 'String' and 'Int'
//var totalPriceMessage = "The price of the book is $" + totalPrice

// You can write the code like this by converting the integer to a string:
var totalPriceMessage1 = "The price of the book is $" + String(totalPrice)
// There is an alternate way known as String Interpolations to do that. You can write the code like this to create the totalPriceMessage variable:
var totalPriceMessage2 = "The price of the book is $ \(totalPrice)"
