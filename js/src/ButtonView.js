var Button, Component, Gesture, ImageView, ReactiveTextView, Style, Tappable, View, ref;

ref = require("component"), Component = ref.Component, Style = ref.Style, View = ref.View, ImageView = ref.ImageView;

ReactiveTextView = require("ReactiveTextView");

Tappable = require("tappable");

Gesture = require("gesture");

Button = require("./Button");

module.exports = Component("ButtonView", {
  propTypes: {
    button: Button.Kind
  },
  customValues: {
    button: {
      get: function() {
        return this.props.button;
      }
    }
  },
  initValues: function() {
    return {
      gestures: Gesture.ResponderList([this.button.tap, this.button.hold])
    };
  },
  initListeners: function() {
    return this.button.__attachListeners();
  },
  render: function() {
    var icon, text;
    if (this.button.icon != null) {
      icon = ImageView({
        source: this.button.icon,
        style: this.button.iconStyle
      });
    }
    if (this.button.text != null) {
      text = ReactiveTextView({
        getText: this.button.text.getValue,
        style: this.button.textStyle
      });
    }
    return View({
      style: this.button.style,
      children: [icon, text],
      mixins: [this.gestures.touchHandlers]
    });
  }
});

//# sourceMappingURL=../../map/src/ButtonView.map
