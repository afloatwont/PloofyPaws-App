import 'package:flutter/material.dart';
import 'package:restoe/components/dot_indicator.dart';
import 'package:restoe/config/theme/theme.dart';

class OnboardingNavigation extends StatefulWidget {
  final bool isLastPage;
  final VoidCallback onPressed;
  final bool showPageIndicator;
  final int currentPage;
  final int totalPages;

  const OnboardingNavigation({
    super.key,
    required this.isLastPage,
    required this.onPressed,
    required this.showPageIndicator,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  State<OnboardingNavigation> createState() => _OnboardingNavigationState();
}

class _OnboardingNavigationState extends State<OnboardingNavigation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _nextButtonAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _nextButtonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isLastPage) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLastPage != widget.isLastPage) {
      if (widget.isLastPage) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLastPage) {
      return GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _nextButtonAnimation,
          builder: (context, child) {
            return Transform.translate(
              //animate left to right
              offset: Offset(0, 100 * (1 - _nextButtonAnimation.value)),
              child: child,
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Started',
                  style: typography(context).largeBody.copyWith(
                        color: Colors.black,
                      ),
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 30.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget.isLastPage ? const SizedBox.shrink() : _buildPageIndicator(),
        GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return AnimatedDotIndicator(
        count: widget.totalPages, currentIndex: widget.currentPage, selectedDotColor: colors(context).primary.s500);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
