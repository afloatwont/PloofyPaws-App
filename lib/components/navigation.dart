import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class ItemNavigationView {
  final Widget childBefore;
  final Widget childAfter;

  ItemNavigationView({
    required this.childAfter,
    required this.childBefore,
  });
}

class NavigationView extends StatefulWidget {
  final Function(int) onChangePage;
  final Color? backgroundColor;
  final Color? borderTopColor;
  final Curve? curve;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Duration? durationAnimation;
  final List<ItemNavigationView> items;
  const NavigationView({
    super.key,
    required this.onChangePage,
    required this.items,
    this.durationAnimation,
    this.backgroundColor,
    this.borderRadius,
    this.color,
    this.curve,
    this.borderTopColor,
  });

  @override
  State<StatefulWidget> createState() => _NavigationView();
}

class _NavigationView extends State<NavigationView> {
  final double borderRadius = 10.0;
  late int _currentPage = 0;

  final Color color = primary;
  Duration durationAnimation = const Duration(milliseconds: 350);

  @override
  void initState() {
    if (widget.durationAnimation != null) durationAnimation = widget.durationAnimation!;
    _currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        color: (widget.backgroundColor != null) ? widget.backgroundColor : Colors.white,
        height: 60,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 2,
              color: (widget.borderTopColor != null) ? widget.borderTopColor! : Colors.grey.withAlpha(60),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (p0, constraints) {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        curve: (widget.curve != null) ? widget.curve! : Curves.easeInOutQuint,
                        right:
                            (constraints.maxWidth / widget.items.length) * ((widget.items.length - 1) - _currentPage),
                        width: constraints.maxWidth / widget.items.length,
                        height: constraints.maxHeight,
                        duration: Duration(milliseconds: durationAnimation.inMilliseconds),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 0, left: (45 / widget.items.length), right: (45 / widget.items.length)),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: (widget.borderRadius != null)
                                      ? widget.borderRadius
                                      : BorderRadius.circular(borderRadius)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 4, right: 4),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: durationAnimation.inMilliseconds ~/ 2),
                                        width: double.maxFinite,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: (widget.color != null) ? widget.color! : color,
                                          borderRadius: (widget.borderRadius != null)
                                              ? widget.borderRadius!
                                              : const BorderRadius.only(
                                                  bottomLeft: Radius.circular(11.1),
                                                  bottomRight: Radius.circular(11.1),
                                                ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Row(
                          children: widget.items
                              .map((e) => Flexible(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _currentPage = widget.items.indexOf(e);
                                          widget.onChangePage.call(widget.items.indexOf(e));
                                        });
                                      },
                                      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                        return Center(
                                            child: AnimatedCrossFade(
                                                firstChild: e.childBefore,
                                                secondChild: e.childAfter,
                                                crossFadeState: (_currentPage == widget.items.indexOf(e))
                                                    ? CrossFadeState.showSecond
                                                    : CrossFadeState.showFirst,
                                                duration:
                                                    Duration(milliseconds: durationAnimation.inMilliseconds ~/ 2)));
                                      }),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}
