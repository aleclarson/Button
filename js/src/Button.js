var Component, Holdable, NativeValue, Tappable, getArgProp, ref, type;

ref = require("component"), Component = ref.Component, NativeValue = ref.NativeValue;

getArgProp = require("getArgProp");

Holdable = require("holdable");

Tappable = require("tappable");

type = Component.Type("Button");

type.loadComponent(function() {
  return require("./ButtonView");
});

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

type.defineStyles({
  container: {
    flexDirection: "row",
    alignItems: "center"
  },
  icon: {},
  text: {}
});

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

module.exports = type.build();

//# sourceMappingURL=../../map/src/Button.map
