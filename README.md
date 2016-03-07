
# Button v1.0.0 [![stable](http://badges.github.io/stability-badges/dist/stable.svg)](http://github.com/badges/stability-badges)

```coffee
{ Button } = require "Button"

button = Button {
  icon: require "image!home"
  text: "Home"
}

button.didTap ->
  console.log "Button was tapped!"

button.render {
  style: {}
  iconStyle: {}
  textStyle: {}
}
```
