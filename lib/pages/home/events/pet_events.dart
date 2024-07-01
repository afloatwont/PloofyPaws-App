import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_modal_bottom_sheet.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/home/core/data/cities.dart';
import 'package:ploofypaws/pages/home/events/event_details.dart';
import 'package:ploofypaws/pages/home/events/widgets/event_card.dart';
import 'package:ploofypaws/pages/home/events/widgets/featured_events.dart';

class PetEvents extends StatefulWidget {
  const PetEvents({super.key});

  @override
  State<PetEvents> createState() => _PetEventsState();
}

class _PetEventsState extends State<PetEvents> {
  Cities? selectedCity;

  final List<PetEventItem> _items = [
    PetEventItem(
      imageAsset: 'assets/images/placeholders/pet_event_placeholder.png',
      title: 'Pet shop Founders Meet and greet',
      dateTime: '24 May  | 10:00 AM - 12:00 PM',
      location: 'Lodhi Garden, New Delhi',
      price: 'Rs. 500 onwards',
    ),
    PetEventItem(
      imageAsset: 'assets/images/placeholders/pet_event_placeholder.png',
      title: ' Pet fest',
      dateTime: '24 May  | 10:00 AM - 12:00 PM',
      location: 'Lodhi Garden, New Delhi',
      price: 'Rs. 500 onwards',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      previousPageTitle: 'Home',
      appBarTrailing: GestureDetector(
        onTap: () {
          showAdaptiveModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 16),
                      const InputLabel(label: "Select a city", size: 32),
                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: citiesItems.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final data = citiesItems[index];
                          return ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                      color: selectedCity == data ? colors(context).primary.s600 : Colors.grey,
                                      width: selectedCity == data ? 2 : 1)),
                              tileColor: selectedCity == data ? colors(context).primary.s50 : Colors.white,
                              onTap: () {
                                setState(() {
                                  selectedCity = data;
                                });
                                Navigator.pop(context);
                              },
                              title: Text(data.cityName ?? "", style: typography(context).smallBody),
                              trailing: data.cityyIcon);
                        },
                      )
                    ],
                  ),
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.location, size: 16, color: colors(context).primary.s800),
              const SizedBox(width: 8),
              Text(selectedCity?.cityName ?? "New Delhi",
                  style: typography(context).smallBody.copyWith(
                        color: colors(context).primary.s800,
                      )),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down_circle, size: 16, color: Colors.black),
            ],
          ),
        ),
      ),
      appBarBottom: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CupertinoSearchTextField(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('PloofyPaws',
                    style: typography(context)
                        .ploofypawsTitle
                        .copyWith(color: Colors.grey, fontSize: 26, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    const SizedBox(width: 16),
                    Text('Pet Events',
                        style: typography(context).title2.copyWith(
                            color: Colors.grey, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    const SizedBox(width: 16),
                    const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
                Text(
                  'Happening in your city! ',
                  style:
                      typography(context).body.copyWith(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: InputLabel(label: "Upcoming Events", size: 16),
          ),
          FeaturedEvents(items: _items),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: InputLabel(label: "Popular Events", size: 16),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PetEventDetails()));
                  },
                  child: PetEventsCard(eventItem: _items[index]));
            },
          ),
        ]),
      ),
    );
  }
}
