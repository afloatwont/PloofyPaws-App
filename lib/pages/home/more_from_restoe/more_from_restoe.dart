import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restoe/components/dot_indicator.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/home/core/data/more_from_restoe_services.dart';

class MoreFromRestoe extends StatefulWidget {
  const MoreFromRestoe({super.key});

  @override
  State<MoreFromRestoe> createState() => _MoreFromRestoeState();
}

class _MoreFromRestoeState extends State<MoreFromRestoe> {
  int _currentPageIndex = 0;
  late Timer _timer;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPageIndex < moreServices.length - 1) {
        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
      } else {
        _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: moreServices.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final data = moreServices[index];
              final color = _getColorForId(data.id, context);
              final navigator = _navigateToKnowMore(data.id, context);
              return GestureDetector(
                onTap: navigator,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 16,
                    right: _currentPageIndex == index ? 16 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(top: 16, right: 16, child: Icon(Iconsax.medal_star)),
                      Positioned(
                        bottom: 0,
                        right: -10,
                        child: Image.asset(
                          data.image ?? "",
                          height: 80,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title ?? "",
                                style: typography(context).smallBody.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                data.description ?? "",
                                style: typography(context).smallBody.copyWith(
                                      color: colors(context).common.black?.s200,
                                      fontSize: 10,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Tap to know more',
                                    style: typography(context)
                                        .smallBody
                                        .copyWith(color: colors(context).common.white?.s200, fontSize: 10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        AnimatedDotIndicator(count: moreServices.length, currentIndex: _currentPageIndex),
      ],
    );
  }

  void Function() _navigateToKnowMore(int id, BuildContext context) {
    switch (id) {
      case 1:
        return () {
          Navigator.pushNamed(context, '/know-more');
        };
      case 2:
        return () {
          Navigator.pushNamed(context, '/know-more');
        };
      default:
        return () {};
    }
  }

  Color _getColorForId(int id, BuildContext context) {
    switch (id) {
      case 1:
        return colors(context).primary.s200;
      case 2:
        return colors(context).warning.s200;
      default:
        return Colors.grey;
    }
  }
}
