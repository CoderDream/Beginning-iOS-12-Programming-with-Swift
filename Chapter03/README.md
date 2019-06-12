## Chapter 3 Hello World! Build Your First App in Swift


### Coding the Hello World Button

```
@IBAction func showMessage(sender: UIButton) {
    let alertController = UIAlertController(title: "Welcome to My First App",
     	message: "Hello World", preferredStyle: UIAlertController.Style.alert)
    alertController.addAction(UIAlertAction(title: "OK", 
    	style: UIAlertAction.Style.default, handler: nil))
    present(alertController, animated: true, completion: nil)
}
```

### Exercise #2
```
@IBAction func showMessage(sender: UIButton) {
    // Initialize the dictionary for the emoji icons
    var emojiDict: [String: String] = ["👻": "Ghost",
                                       "💩": "Poop",
                                       "😤": "Angry",
                                       "🤓": "Nerdy",
                                       "😱": "Scream",
                                       "👾": "Alien monster",
                                       "🤖": "Robot face"]
    
    // If you forgot how to do it, refer to the previous chapter
    // Fill in the code below
    // The sender is the button that is tapped by the user.
    // Here we store the sender in the selectedButton constant
    let selectedButton = sender
    // Get the emoji from the title label of the selected button
    if let wordToLookup = selectedButton.titleLabel?.text {
        // Get the meaning of the emoji from the dictionary
        let meaning = emojiDict[wordToLookup]

        // Fill in the code below
        // Change the line below to display the meaning of the emoji instead of Hello World
        let alertController = UIAlertController(title: "Meaning", 
        	message: meaning, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", 
        	style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
```