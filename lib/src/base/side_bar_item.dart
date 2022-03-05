import 'package:arna/arna.dart';

class ArnaSideBarItem extends StatelessWidget {
  /// Creates a side bar item.
  const ArnaSideBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.badge,
    this.compact = false,
    this.selected = false,
    this.isFocusable = true,
    this.autofocus = false,
    this.accentColor,
    this.cursor = MouseCursor.defer,
    this.semanticLabel,
  }) : super(key: key);

  /// The text label of the item.
  final String label;

  /// The icon of the item.
  final IconData icon;

  /// The callback that is called when an item is tapped.
  final VoidCallback? onPressed;

  /// The [ArnaBadge] of the item.
  final ArnaBadge? badge;

  /// Whether this item is compact or not.
  final bool compact;

  /// Whether this item is selected or not.
  final bool selected;

  /// Whether this item is focusable or not.
  final bool isFocusable;

  /// Whether this item should focus itself if nothing else is already
  /// focused.
  final bool autofocus;

  /// The color of the item's focused border.
  final Color? accentColor;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  final MouseCursor cursor;

  /// The semantic label of the item.
  final String? semanticLabel;

  Widget _buildChild(BuildContext context, bool enabled) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            Padding(
              padding: Styles.normal,
              child: Icon(
                icon,
                size: Styles.iconSize,
                color: ArnaDynamicColor.resolve(
                  !enabled
                      ? ArnaColors.disabledColor
                      : selected
                          ? ArnaDynamicColor.innerColor(
                              accentColor ?? ArnaTheme.of(context).accentColor,
                            )
                          : ArnaColors.iconColor,
                  context,
                ),
              ),
            ),
            const SizedBox(width: Styles.padding),
            Text(
              label,
              style: ArnaTheme.of(context).textTheme.buttonTextStyle.copyWith(
                    color: ArnaDynamicColor.resolve(
                      !enabled
                          ? ArnaColors.disabledColor
                          : selected
                              ? ArnaDynamicColor.innerColor(accentColor ??
                                  ArnaTheme.of(context).accentColor)
                              : ArnaColors.primaryTextColor,
                      context,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color accent = accentColor ?? ArnaTheme.of(context).accentColor;
    bool buttonSelected = selected;
    return Padding(
      padding: Styles.small,
      child: ArnaBaseButton(
        builder: (context, enabled, hover, focused, pressed, selected) {
          selected = buttonSelected;
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Stack(
                alignment: compact ? Alignment.topRight : Alignment.centerRight,
                children: [
                  AnimatedContainer(
                    height: Styles.sideBarItemHeight,
                    width: double.infinity,
                    duration: Styles.basicDuration,
                    curve: Styles.basicCurve,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: Styles.borderRadius,
                      border: Border.all(
                        color: ArnaDynamicColor.resolve(
                          pressed
                              ? ArnaDynamicColor.colorBlender(
                                  accent,
                                  28,
                                  isBorder: true,
                                )
                              : focused
                                  ? ArnaDynamicColor.colorBlender(
                                      accent,
                                      14,
                                      isBorder: true,
                                    )
                                  : ArnaColors.color00,
                          context,
                        ),
                      ),
                      color: !enabled
                          ? ArnaDynamicColor.resolve(
                              ArnaColors.backgroundColor,
                              context,
                            )
                          : pressed
                              ? accent
                              : selected
                                  ? ArnaDynamicColor.colorBlender(accent, 10)
                                  : hover
                                      ? ArnaDynamicColor.colorBlender(
                                          accent,
                                          20,
                                        )
                                      : focused
                                          ? ArnaDynamicColor.colorBlender(
                                              accent,
                                              30,
                                            )
                                          : ArnaDynamicColor.resolve(
                                              ArnaColors.sideColor,
                                              context,
                                            ),
                    ),
                    padding: Styles.horizontal,
                    child: _buildChild(context, enabled),
                  ),
                  if (badge != null)
                    compact
                        ? badge!
                        : Padding(padding: Styles.horizontal, child: badge!),
                ],
              ),
              AnimatedContainer(
                height: selected ? Styles.iconSize : 0,
                width: Styles.smallPadding,
                duration: Styles.basicDuration,
                curve: Styles.basicCurve,
                decoration: BoxDecoration(
                  borderRadius: Styles.borderRadius,
                  color: ArnaDynamicColor.colorBlender(accent, 85),
                ),
              ),
            ],
          );
        },
        onPressed: onPressed,
        tooltipMessage: compact ? label : null,
        isFocusable: isFocusable,
        autofocus: autofocus,
        cursor: cursor,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
