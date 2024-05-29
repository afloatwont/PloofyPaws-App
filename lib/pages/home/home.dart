import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/home/core/data/services_data.dart';
import 'package:restoe/pages/home/events/pet_events.dart';
import 'package:restoe/pages/home/more_from_restoe/more_from_restoe.dart';
import 'package:restoe/pages/home/services/pet_services.dart';
import 'package:restoe/pages/home/skelton.dart';
import 'package:restoe/pages/home/widgets/ai_card.dart';
import 'package:restoe/pages/home/widgets/footer.dart';
import 'package:restoe/pages/home/widgets/stacked_cards.dart';
import 'package:restoe/pages/home/widgets/tracker_card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool _loading = false;

  fetchDummyData() async {
    setState(() {
      _loading = true;
    });

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    fetchDummyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SkeletonHome();
    }
    return ListView(
      children: [
        AICard(onTap: () {}),
        const SizedBox(height: 16),
        _buildLabel(context, "What are you looking for", false, null),
        const SizedBox(height: 16),
        const PetServices(),
        _buildLabel(context, "Popular Events", true, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PetEvents()));
        }),
        const SizedBox(height: 16),
        EventStackedCards(
            color1: const Color(0xff90706C), //will come from backend
            color2: const Color(0xffE2B99B), //will come from backend
            onTap: () {},
            image: [
              popularEvents[0],
              popularEvents[1],
              popularEvents[0],
            ]),
        const SizedBox(height: 16),
        _buildLabel(context, "More from Restoe", false, null),
        const SizedBox(height: 16),
        const MoreFromRestoe(),
        const SizedBox(height: 24),
        const TrackerAdCard(),
        const Footer(),
      ],
    );
  }
}

Padding _buildLabel(BuildContext context, String? title, bool isViewAll, void Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        InputLabel(
          label: title ?? "",
          size: 16,
        ),
        const Spacer(),
        if (isViewAll)
          InkWell(
            onTap: onTap,
            child: Text(
              "View All",
              style: typography(context).smallBody.copyWith(color: colors(context).primary.s500),
            ),
          )
      ],
    ),
  );
}
