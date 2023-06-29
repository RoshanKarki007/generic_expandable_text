import 'package:flutter/material.dart';

class GenericExpandableText extends StatefulWidget {
  final bool? hasReadMore;
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final Color? readmoreColor;
  final Color? readlessColor;
  const GenericExpandableText(
    this.text, {
    super.key,
    this.maxLines,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.readlessColor,
    this.readmoreColor,
    this.hasReadMore = false,
  }) : assert(
          hasReadMore != null && maxLines != 0,
        );

  @override
  State<GenericExpandableText> createState() => _GenericExpandableTextState();
}

class _GenericExpandableTextState extends State<GenericExpandableText> {
  bool? isReadMore;
  Future<bool?> getTotalNumerOfLines({
    required String value,
    int? maxLines,
    BoxConstraints? parentsconstraints,
    required TextStyle style,
  }) async {
    await Future.delayed(Duration.zero).then((value) {});
    if (maxLines == null || widget.maxLines == null) {
      listenableMaxLines.value = widget.maxLines;
    }

    var text = value;
    var span = TextSpan(
      text: text,
      style: style,
    );
    var tp = TextPainter(
      text: span,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      textAlign: widget.textAlign ?? TextAlign.start,
    );
    var widgetWidth = textKey.currentContext?.size?.width;

    tp.layout(
      maxWidth: widgetWidth ?? double.infinity,
    ); // equals the parent screen width
    if (tp.didExceedMaxLines) {
      isReadMore = true;
      listenableMaxLines.value = tp.maxLines;
    }

    if (maxLines == null) {
      return null;
    }
    if (parentsconstraints != null) {
      if (parentsconstraints.maxHeight < tp.height + (style.fontSize ?? 0)) {
        double availableHeight = parentsconstraints.maxHeight;
        double? lineSpacing = style.height;
        double? fontSize = style.fontSize;
        double totalLineHeight = (fontSize ?? 0) + (lineSpacing ?? 0);
        int numberOfLines = (availableHeight / totalLineHeight).floor();
        listenableMaxLines.value = numberOfLines > 0 ? numberOfLines : 1;
        return null;
      }
    }

    return Future.value(tp.didExceedMaxLines);
  }

  final textKey = GlobalKey();

  final ValueNotifier<int?> listenableMaxLines = ValueNotifier<int?>(null);
  final mainWidgetKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ValueListenableBuilder(
          key: mainWidgetKey,
          valueListenable: listenableMaxLines,
          builder: (context, value, child) {
            return Wrap(
              key: widget.key,
              children: [
                Text(
                  key: textKey,
                  widget.text,
                  style: const TextStyle().copyWith(
                    background: widget.style?.background,
                    backgroundColor: widget.style?.backgroundColor,
                    color: widget.style?.color,
                    debugLabel: widget.style?.debugLabel,
                    decoration: widget.style?.decoration,
                    decorationColor: widget.style?.decorationColor,
                    decorationStyle: widget.style?.decorationStyle,
                    decorationThickness: widget.style?.decorationThickness,
                    fontFamily: widget.style?.fontFamily,
                    fontFamilyFallback: widget.style?.fontFamilyFallback,
                    fontFeatures: widget.style?.fontFeatures,
                    fontSize: widget.style?.fontSize ?? 13,
                    fontStyle: widget.style?.fontStyle,
                    fontVariations: widget.style?.fontVariations,
                    fontWeight: widget.style?.fontWeight,
                    foreground: widget.style?.foreground,
                    height: widget.style?.height ?? 1.2,
                    inherit: widget.style?.inherit,
                    leadingDistribution: widget.style?.leadingDistribution,
                    letterSpacing: widget.style?.letterSpacing,
                    locale: widget.style?.locale,
                    overflow: widget.style?.overflow,
                    shadows: widget.style?.shadows,
                    textBaseline: widget.style?.textBaseline,
                    wordSpacing: widget.style?.wordSpacing,
                  ),
                  overflow: listenableMaxLines.value == null
                      ? null
                      : TextOverflow.ellipsis,
                  textAlign: widget.textAlign,
                  textDirection: widget.textDirection,
                  locale: widget.locale,
                  maxLines: value,
                ),
                if (widget.hasReadMore!)
                  FutureBuilder(
                    future: getTotalNumerOfLines(
                      value: widget.text,
                      maxLines: listenableMaxLines.value,
                      parentsconstraints: constraints,
                      style: const TextStyle().copyWith(
                        background: widget.style?.background,
                        backgroundColor: widget.style?.backgroundColor,
                        color: widget.style?.color,
                        debugLabel: widget.style?.debugLabel,
                        decoration: widget.style?.decoration,
                        decorationColor: widget.style?.decorationColor,
                        decorationStyle: widget.style?.decorationStyle,
                        decorationThickness: widget.style?.decorationThickness,
                        fontFamily: widget.style?.fontFamily,
                        fontFamilyFallback: widget.style?.fontFamilyFallback,
                        fontFeatures: widget.style?.fontFeatures,
                        fontSize: widget.style?.fontSize ?? 13,
                        fontStyle: widget.style?.fontStyle,
                        fontVariations: widget.style?.fontVariations,
                        fontWeight: widget.style?.fontWeight,
                        foreground: widget.style?.foreground,
                        height: widget.style?.height ?? 1.2,
                        inherit: widget.style?.inherit,
                        leadingDistribution: widget.style?.leadingDistribution,
                        letterSpacing: widget.style?.letterSpacing,
                        locale: widget.style?.locale,
                        overflow: widget.style?.overflow,
                        shadows: widget.style?.shadows,
                        textBaseline: widget.style?.textBaseline,
                        wordSpacing: widget.style?.wordSpacing,
                      ),
                    ),
                    builder: (context, snapshot) {
                      bool? hasExcitedLimit = snapshot.data;

                      return hasExcitedLimit != null
                          ? GestureDetector(
                              onTap: () {
                                if (hasExcitedLimit) {
                                  listenableMaxLines.value = 100000000;
                                  isReadMore = false;
                                } else {
                                  listenableMaxLines.value = widget.maxLines;
                                  isReadMore = true;
                                }
                              },
                              child: Text(
                                isReadMore != null
                                    ? isReadMore!
                                        ? 'Read more'
                                        : 'Read less'
                                    : '',
                                style: const TextStyle().copyWith(
                                  background: widget.style?.background,
                                  backgroundColor:
                                      widget.style?.backgroundColor,
                                  color: isReadMore != null
                                      ? isReadMore!
                                          ? widget.readmoreColor ??
                                              widget.style?.color
                                          : widget.readlessColor ??
                                              widget.style?.color
                                      : widget.style?.color,
                                  debugLabel: widget.style?.debugLabel,
                                  decoration: widget.style?.decoration,
                                  decorationColor:
                                      widget.style?.decorationColor,
                                  decorationStyle:
                                      widget.style?.decorationStyle,
                                  decorationThickness:
                                      widget.style?.decorationThickness,
                                  fontFamily: widget.style?.fontFamily,
                                  fontFamilyFallback:
                                      widget.style?.fontFamilyFallback,
                                  fontFeatures: widget.style?.fontFeatures,
                                  fontSize: widget.style?.fontSize ?? 13,
                                  fontStyle: widget.style?.fontStyle,
                                  fontVariations: widget.style?.fontVariations,
                                  fontWeight: widget.style?.fontWeight,
                                  foreground: widget.style?.foreground,
                                  height: widget.style?.height ?? 1.2,
                                  inherit: widget.style?.inherit,
                                  leadingDistribution:
                                      widget.style?.leadingDistribution,
                                  letterSpacing: widget.style?.letterSpacing,
                                  locale: widget.style?.locale,
                                  overflow: widget.style?.overflow,
                                  shadows: widget.style?.shadows,
                                  textBaseline: widget.style?.textBaseline,
                                  wordSpacing: widget.style?.wordSpacing,
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
              ],
            );
          });
    });
  }
}
