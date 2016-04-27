var Factory, Holdable, NativeValue, Tappable, define, mergeDefaults, sync;

NativeValue = require("component").NativeValue;

mergeDefaults = require("mergeDefaults");

Holdable = require("holdable");

Tappable = require("tappable");

Factory = require("factory");

define = require("define");

sync = require("sync");

module.exports = Factory("Button", {
  optionTypes: {
    icon: Number.Maybe,
    text: String.Maybe,
    getText: Function.Maybe,
    maxTapCount: Number.Maybe,
    minHoldTime: Number.Maybe,
    style: Object.Maybe,
    iconStyle: Object.Maybe,
    textStyle: Object.Maybe
  },
  optionDefaults: {
    maxTapCount: 1
  },
  customValues: {
    render: {
      lazy: function() {
        var render;
        render = this.__loadComponent();
        return (function(_this) {
          return function(props) {
            if (props == null) {
              props = {};
            }
            props.button = _this;
            return render(props);
          };
        })(this);
      }
    }
  },
  initValues: function(options) {
    return {
      icon: options.icon,
      text: null,
      style: options.style != null ? options.style : options.style = {},
      iconStyle: options.iconStyle != null ? options.iconStyle : options.iconStyle = {},
      textStyle: options.textStyle != null ? options.textStyle : options.textStyle = {}
    };
  },
  init: function(options) {
    mergeDefaults(this.style, {
      flexDirection: "row",
      alignItems: "center"
    });
    if (options.text != null) {
      this.text = NativeValue(options.text);
    } else if (options.getText != null) {
      this.text = NativeValue(options.getText);
    }
    this.tap = Tappable({
      maxTapCount: options.maxTapCount
    });
    define(this, "didTap", {
      get: function() {
        return this.tap.didTap.listenable;
      }
    });
    if (options.minHoldTime != null) {
      this.hold = Holdable({
        minHoldTime: options.minHoldTime
      });
      return define(this, "didHold", {
        get: function() {
          return this.hold.didHold.listenable;
        }
      });
    }
  },
  __loadComponent: function() {
    return require("./ButtonView");
  },
  __attachListeners: emptyFunction
});

//# sourceMappingURL=../../map/src/Button.map
