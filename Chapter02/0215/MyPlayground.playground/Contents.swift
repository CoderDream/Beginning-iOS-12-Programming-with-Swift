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

