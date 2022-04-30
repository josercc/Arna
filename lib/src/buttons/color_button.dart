import 'package:arna/arna.dart';

/// An Arna-styled color button.
class ArnaColorButton<T> extends StatelessWidget {
  /// Creates An Arna-styled color button.
  ///
  /// The color button itself does not maintain any state. Instead, when the color button is selected, the widget calls
  /// the [onPressed] callback. Most widgets that use a color button will listen for the [onPressed] callback and
  /// rebuild the color button with a new [groupValue] to update the visual appearance of the color button.
  ///
  /// The following arguments are required:
  ///
  /// * [value] and [groupValue] together determine whether the color button is selected.
  /// * [onPressed] is called when the user selects this color button.
  const ArnaColorButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onPressed,
    required this.color,
    this.isFocusable = true,
    this.autofocus = false,
    this.cursor = MouseCursor.defer,
    this.semanticLabel,
  }) : super(key: key);

  /// The value represented by this button.
  final T value;

  /// The currently selected value for a group of color buttons.
  ///
  /// This color button is considered selected if its [value] matches the [groupValue].
  final T? groupValue;

  /// The callback that is called when a button is tapped.
  final VoidCallback? onPressed;

  /// The color of the button.
  final Color color;

  /// Whether this button is focusable or not.
  final bool isFocusable;

  /// Whether this button should focus itself if nothing else is already focused.
  final bool autofocus;

  /// The cursor for a mouse pointer when it enters or is hovering over the button.
  final MouseCursor cursor;

  /// The semantic label of the button.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.small,
      child: ArnaBaseWidget(
        builder: (context, enabled, hover, focused, pressed, selected) {
          selected = value == groupValue;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedContainer(
                height: Styles.colorButtonSize,
                width: Styles.colorButtonSize,
                duration: Styles.basicDuration,
                curve: Styles.basicCurve,
                decoration: BoxDecoration(
                  borderRadius: Styles.radioBorderRadius,
                  border: Border.all(
                    color: ArnaDynamicColor.resolve(
                      !enabled
                          ? ArnaDynamicColor.applyOverlay(ArnaDynamicColor.onBackgroundColor(color))
                          : ArnaDynamicColor.outerColor(color),
                      context,
                    ),
                  ),
                  color: pressed || hover || focused ? ArnaDynamicColor.applyOverlay(color) : color,
                ),
              ),
              AnimatedContainer(
                height: selected ? Styles.colorButtonIndicatorSize : 0,
                width: selected ? Styles.colorButtonIndicatorSize : 0,
                duration: Styles.basicDuration,
                curve: Styles.basicCurve,
                decoration: BoxDecoration(
                  borderRadius: Styles.radioBorderRadius,
                  color: !enabled
                      ? ArnaDynamicColor.resolve(ArnaColors.backgroundColor, context)
                      : ArnaDynamicColor.onBackgroundColor(color),
                ),
              ),
            ],
          );
        },
        onPressed: onPressed,
        isFocusable: isFocusable,
        autofocus: autofocus,
        cursor: cursor,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
