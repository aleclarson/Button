var Factory, Holdable, Shape, Tappable;

Shape = require("type-utils").Shape;

Holdable = require("holdable");

Tappable = require("tappable");

Factory = require("factory");

module.exports = Factory("Button", {
  optionTypes: {
    icon: [Number, Void],
    text: [String, Void],
    getText: [Function, Void],
    maxTapCount: [Number, Void],
    minHoldTime: [Number, Void]
  },
  optionDefaults: {
    maxTapCount: 1
  },
  customValues: {
    render: {
      lazy: function() {
        var render;
        render = this._getComponent();
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
  init: function(options) {
    this.icon = options.icon;
    if (options.text != null) {
      this.text = NativeValue(options.text);
    } else if (options.getText != null) {
      this.text = NativeValue(options.getText);
    }
    this.tap = Tappable({
      maxTapCount: options.maxTapCount
    });
    this.tap.mixin(this);
    if (options.minHoldTime != null) {
      this.hold = Holdable({
        minHoldTime: options.minHoldTime
      });
      return this.hold.mixin(this);
    }
  },
  _getComponent: function() {
    return require("./ButtonView");
  }
});

//# sourceMappingURL=../../map/src/Button.map
