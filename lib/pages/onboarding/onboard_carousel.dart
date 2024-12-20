import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/auth/sign-in/sign_in.dart';
import 'package:ploofypaws/pages/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({super.key});

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  int totalPages = 3;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  bool _isLastPage = false;
  Offset offset = const Offset(0, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: PageView(
          clipBehavior: Clip.antiAlias,
          controller: _pageController,
          onPageChanged: _updateCurrentPage,
          children: [
            _buildPage(
              'Your home page',
              'The go-to-place for all your major updates on \nploofypaws. husahduasd ',
              1,
            ),
            _buildPage(
              'Never miss a thing!',
              'Keeping tracker of your sitting schedule was \nnever easier dsad a',
              2,
            ),
            _buildPage(
              'All-in-one learning centre',
              'Mra naam Angad hai, aur main aapko kuch sikhane \nwala hoona. hueheue',
              3,
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: OnboardingNavigation(
            isLastPage: _isLastPage,
            onPressed: _handleNextButton,
            showPageIndicator: !_isLastPage,
            currentPage: _currentPage,
            totalPages: totalPages,
          ),
        ));
  }

  void _updateCurrentPage(int page) {
    setState(() {
      _currentPage = page;
      _isLastPage = _currentPage == (totalPages - 1);
    });
  }

  Future<void> _handleNextButton() async {
    if (_isLastPage) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      // If user has seen onboarding, then we set this to true

      preferences.setBool('has_seen_onboarding', true);

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
          MaterialWithModalsPageRoute(builder: (context) => const SignInPage()),
          (route) => false);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  Widget _buildPage(String title, String description, int imageIndex) {
    final urlProvider = context.watch<UrlProvider>();
    final imageUrl = urlProvider
            .urlMap['assets/images/onboarding/onboarding_$imageIndex.png'] ??
        '';

    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: null,
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24.0, top: 60.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: typography(context).ploofypawsTitle.copyWith(
                        fontSize: 24, letterSpacing: 0.5, color: Colors.white)),
                const SizedBox(height: 12.0),
                Text(
                  description,
                  style: typography(context).body.copyWith(
                        color: colors(context).onSurface.s50,
                      ),
                ),
                const SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
