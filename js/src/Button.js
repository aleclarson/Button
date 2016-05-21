var Component, Gesture, Holdable, ImageView, NativeValue, ReactiveTextView, Tappable, View, getArgProp, ref, type;

ref = require("component"), Component = ref.Component, NativeValue = ref.NativeValue, View = ref.View, ImageView = ref.ImageView;

ReactiveTextView = require("ReactiveTextView");

getArgProp = require("getArgProp");

Holdable = require("holdable");

Tappable = require("tappable");

Gesture = require("gesture");

type = Component.Type("Button");

type.optionTypes = {
  icon: Number.Maybe,
  text: String.Maybe,
  getText: Function.Maybe,
  maxTapCount: Number.Maybe,
  minHoldTime: Number.Maybe
};

type.optionDefaults = {
  maxTapCount: 1
};

type.defineValues({
  icon: getArgProp("icon"),
  text: function(options) {
    var value;
    value = options.getText || options.text;
    if (value === void 0) {
      return;
    }
    return NativeValue(value);
  },
  tap: function(options) {
    return Tappable({
      maxTapCount: options.maxTapCount
    });
  },
  hold: function(options) {
    if (options.minHoldTime == null) {
      return;
    }
    return Holdable({
      minHoldTime: options.minHoldTime
    });
  },
  _gestures: function() {
    if (!this.hold) {
      return this.tap;
    }
    return Gesture.ResponderList([this.tap, this.hold]);
  }
});

type.defineFrozenValues({
  didTap: function() {
    return this.tap.didTap.listenable;
  },
  didHold: function() {
    if (this.hold) {
      return this.hold.didHold.listenable;
    }
  }
});

type.defineStyles({
  container: {
    flexDirection: "row",
    alignItems: "center"
  },
  icon: {},
  text: {}
});

type.render(function() {
  return View({
    style: this.styles.container(),
    children: [this.__renderIcon(), this.__renderText()],
    mixins: [this._gestures.touchHandlers]
  });
});

type.defineMethods({
  __renderIcon: function() {
    if (!this.icon) {
      return;
    }
    return ImageView({
      source: this.icon,
      style: this.styles.icon()
    });
  },
  __renderText: function() {
    if (!this.text) {
      return;
    }
    return ReactiveTextView({
      getText: this.text.getValue,
      style: this.styles.text()
    });
  }
});

module.exports = type.build();

//# sourceMappingURL=../../map/src/Button.map
