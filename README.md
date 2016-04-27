
# Button v1.0.0 ![stable](https://img.shields.io/badge/stability-stable-4EBA0F.svg?style=flat)

A button model + view designed for React Native + CoffeeScript.

-

### options

##### icon : Number.Maybe

Combines with `options.iconStyle` and an `ImageView`.

#### text : String.Maybe

Combines with `options.textStyle` and a `TextView`.

**Note:** Cannot be used with `options.getText`!

#### getText : Function.Maybe

If defined, this must depend on a reactive `String`!

#### maxTapCount : Number.Maybe

The number of taps that `this.tap` can recognize.

#### minHoldTime : Number.Maybe

This must be defined for `this.hold` to be created.

#### style : Object.Maybe

The style applied to the base container `View`.

#### iconStyle : Object.Maybe

The style applied to the icon's `ImageView`.

#### textStyle : Object.Maybe

The style applied to the text's `TextView`.

### properties

#### didTap : Event

Emits when a tap is recognized.

This is a shortcut to `this.tap.didTap`.

#### didHold : Event

Emits when a long press is recognized.

Only exists when `options.minHoldTime` is defined.

This is a shortcut to `this.hold.didHold`.

#### render() : ReactElement

Renders the button using the properties of this instance.
