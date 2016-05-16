var Button, Component, Gesture, ImageView, ReactiveTextView, Tappable, View, ref, type;

ref = require("component"), Component = ref.Component, View = ref.View, ImageView = ref.ImageView;

ReactiveTextView = require("ReactiveTextView");

Tappable = require("tappable");

Gesture = require("gesture");

Button = require("./Button");

type = Component();

type.contextType = Button;

type.render(function() {
  var gestures, icon, text;
  if (this.icon) {
    icon = ImageView({
      source: this.icon,
      style: this.styles.icon()
    });
  }
  if (this.text) {
    text = ReactiveTextView({
      getText: this.text.getValue,
      style: this.styles.text()
    });
  }
  gestures = Gesture.ResponderList([this.tap, this.hold]);
  return View({
    style: this.styles.container(),
    children: [icon, text],
    mixins: [gestures.touchHandlers]
  });
});

module.exports = type.build();

//# sourceMappingURL=../../map/src/ButtonView.map
