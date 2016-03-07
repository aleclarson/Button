var Button, Component, Gesture, ImageView, ReactiveTextView, Style, Tappable, View, ref;

ref = require("component"), Component = ref.Component, Style = ref.Style, View = ref.View, ImageView = ref.ImageView;

ReactiveTextView = require("ReactiveTextView");

Tappable = require("tappable");

Gesture = require("gesture");

Button = require("./Button");

module.exports = Component("ButtonView", {
  propTypes: {
    button: Button.Kind,
    style: Style,
    iconStyle: Style,
    textStyle: Style
  },
  customValues: {
    button: {
      get: function() {
        return this.props.button;
      }
    }
  },
  render: function() {
    var gestures, icon, text;
    gestures = Gesture.Combinator([this.button.tap, this.button.hold]);
    if (this.button.icon != null) {
      icon = ImageView({
        style: this.props.iconStyle,
        source: this.button.icon
      });
    }
    if (this.button.text != null) {
      text = ReactiveTextView({
        style: this.props.textStyle,
        getText: (function(_this) {
          return function() {
            return _this.button.text.value;
          };
        })(this)
      });
    }
    return View({
      style: [this.styles.button, this.props.style],
      children: [icon, text],
      mixins: [gestures.touchHandlers]
    });
  },
  styles: {
    button: {
      flexDirection: "row"
    }
  }
});

//# sourceMappingURL=../../map/src/ButtonView.map
