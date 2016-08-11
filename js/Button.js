var Gesture, Holdable, ImageView, NativeValue, ReactiveTextView, Tappable, Type, View, fromArgs, ref, type;

ref = require("modx/views"), View = ref.View, ImageView = ref.ImageView;

NativeValue = require("modx/native").NativeValue;

Type = require("modx").Type;

ReactiveTextView = require("ReactiveTextView");

fromArgs = require("fromArgs");

Holdable = require("holdable");

Tappable = require("tappable");

Gesture = require("gesture");

type = Type("Button");

type.defineOptions({
  icon: Number,
  text: String,
  getText: Function,
  maxTapCount: Number.withDefault(1),
  minHoldTime: Number,
  preventDistance: Number,
  centerIcon: Boolean.withDefault(false)
});

type.defineValues(function(options) {
  return {
    _icon: options.icon,
    _centerIcon: options.centerIcon
  };
});

type.defineValues({
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
  _touchHandlers: function() {
    var responder;
    if (!this._hold) {
      return this._tap.touchHandlers;
    }
    responder = Gesture.ResponderList([this._tap, this._hold]);
    return responder.touchHandlers;
  }
});

type.defineGetters({
  didTap: function() {
    return this._tap.didTap.listenable;
  },
  didHold: function() {
    if (this._hold) {
      return;
    }
    return this._hold.didHold.listenable;
  },
  didReject: function() {
    return this._tap.didReject.listenable;
  },
  didGrant: function() {
    return this._tap.didGrant.listenable;
  },
  didEnd: function() {
    return this._tap.didEnd.listenable;
  },
  didTouchStart: function() {
    return this._tap.didTouchStart.listenable;
  },
  didTouchMove: function() {
    return this._tap.didTouchMove.listenable;
  },
  didTouchEnd: function() {
    return this._tap.didTouchEnd.listenable;
  }
});

type.defineHooks({
  __renderIcon: function() {
    var source, style;
    source = this._icon;
    if (!source) {
      return;
    }
    style = [];
    this.styles.icon && style.push(this.styles.icon());
    this._centerIcon && style.push(this.styles.centered());
    return ImageView({
      source: source,
      style: style
    });
  },
  __renderText: function() {
    return this._text && ReactiveTextView({
      getText: (function(_this) {
        return function() {
          return _this._text.value;
        };
      })(this),
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
    mixins: [this._touchHandlers]
  });
});

type.defineStyles({
  container: {
    flexDirection: "row",
    alignItems: "center"
  },
  centered: {
    flex: 1,
    alignSelf: "stretch",
    resizeMode: "center"
  },
  icon: null,
  text: null
});

module.exports = type.build();

//# sourceMappingURL=map/Button.map
