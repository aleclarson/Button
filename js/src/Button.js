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
  minHoldTime: Number.Maybe,
  preventDistance: Number.Maybe
};

type.optionDefaults = {
  maxTapCount: 1
};

type.defineValues({
  _icon: getArgProp("icon"),
  _text: function(options) {
    var value;
    value = options.getText || options.text;
    if (value === void 0) {
      return;
    }
    return NativeValue(value);
  },
  _tap: function(options) {
    return Tappable({
      maxTapCount: options.maxTapCount,
      preventDistance: options.preventDistance
    });
  },
  _hold: function(options) {
    if (options.minHoldTime == null) {
      return;
    }
    return Holdable({
      minHoldTime: options.minHoldTime,
      preventDistance: options.preventDistance
    });
  },
  _gestures: function() {
    if (!this._hold) {
      return this._tap;
    }
    return Gesture.ResponderList([this._tap, this._hold]);
  }
});

type.definePrototype({
  didTap: {
    get: function() {
      return this._tap.didTap.listenable;
    }
  },
  didHold: {
    get: function() {
      if (!this._hold) {
        return;
      }
      return this._hold.didHold.listenable;
    }
  },
  didReject: {
    get: function() {
      return this._tap.didReject.listenable;
    }
  },
  didGrant: {
    get: function() {
      return this._tap.didGrant.listenable;
    }
  },
  didEnd: {
    get: function() {
      return this._tap.didEnd.listenable;
    }
  },
  didTouchStart: {
    get: function() {
      return this._tap.didTouchStart.listenable;
    }
  },
  didTouchMove: {
    get: function() {
      return this._tap.didTouchMove.listenable;
    }
  },
  didTouchEnd: {
    get: function() {
      return this._tap.didTouchEnd.listenable;
    }
  }
});

type.defineMethods({
  __renderIcon: function() {
    if (!this._icon) {
      return;
    }
    return ImageView({
      source: this._icon,
      style: this.styles.icon()
    });
  },
  __renderText: function() {
    if (!this._text) {
      return;
    }
    return ReactiveTextView({
      getText: this._text.getValue,
      style: this.styles.text()
    });
  },
  __renderChildren: function() {
    return [this.__renderIcon(), this.__renderText()];
  }
});

type.render(function() {
  return View({
    style: this.styles.container(),
    children: this.__renderChildren(),
    mixins: [this._gestures.touchHandlers]
  });
});

type.defineStyles({
  container: {
    flexDirection: "row",
    alignItems: "center"
  },
  icon: null,
  text: null
});

module.exports = type.build();

//# sourceMappingURL=../../map/src/Button.map
