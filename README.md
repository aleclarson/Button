
# Button 2.0.0 ![stable](https://img.shields.io/badge/stability-stable-4EBA0F.svg?style=flat)

```coffee
Button = require "Button"

button = Button
  text: "Hello world"

button.didTap ->
  console.log "The user tapped our button!"

button.didHold ->
  console.log "The user long-pressed our button!"

element = button.render()
```

### optionTypes

```coffee
# Supports `require("image!name")`
icon: [ Number, Void ]

# A constant string to render inside the button.
text: [ String, Void ]

# Should return a reactive string if you want to automate re-rendering.
getText: [ Function, Void ]

# The number of taps to recognize before resetting the count. (defaults to 1)
maxTapCount: [ Number, Void ]

# The number of milliseconds to wait before recognizing the hold.
minHoldTime: [ Number, Void ]

# The maximum movement from the first touch before a gesture should not be recognized.
preventDistance: [ Number, Void ]
```

### overrideMethods

You can use `type.overrideMethods()` to take

```coffee
# Override if you want to use another icon component.
__renderIcon()

# Override if you want to use another text component.
__renderText()

# By default, this calls '__renderIcon' and '__renderText'.
__renderChildren()
```

### Styles

You must use `type.appendStyles()` if you want to augment these styles!

```coffee
# The style of the button view.
container:
  flexDirection: "row"
  alignItems: "center"

# The style of the optional icon view.
icon:
  flex: 1
  alignSelf: "stretch"
  resizeMode: "center"

# The style of the optional text view.
text: null
```
