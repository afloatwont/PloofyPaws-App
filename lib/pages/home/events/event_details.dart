import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/tag.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class PetEventDetails extends StatefulWidget {
  const PetEventDetails({super.key});

  @override
  State<PetEventDetails> createState() => _PetEventDetailsState();
}

class _PetEventDetailsState extends State<PetEventDetails> {
  @override
  Widget build(BuildContext context) {
  final urlProvider = context.read<UrlProvider>();
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Button(
          onPressed: () {},
          variant: 'filled',
          label: 'Register',
          buttonColor: colors(context).primary.s500,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) => [
                SliverAppBar(
                  pinned: true,
                  collapsedHeight: 60,
                  expandedHeight: 350,
                  title: isScrolled
                      ? Text('Pet shop Founders Meet and greet',
                          style: typography(context).title3)
                      : null,
                  automaticallyImplyLeading: true,
                  leading: CupertinoButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: urlProvider.urlMap[ 'assets/images/placeholders/pet_card_placeholder.png']!,
                      fit: BoxFit.cover,
                      placeholder: null,
                      errorWidget:(context, url, error) =>  const Icon(Icons.error),
                    ),
                    
                    
                  ),
                )
              ],
          body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                      ),
                      title: Text('Pet shop Founders Meet and greet',
                          style: typography(context).title3),
                      // subtitle: Text('Something', style: typography(context).smallBody),
                      trailing: Button(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        onPressed: () {},
                        variant: 'text',
                        buttonColor: Colors.black,
                        buttonIcon: const Icon(Iconsax.heart),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, bottom: 16),
                      child: Tag(label: "₹ 500 onwards", color: 'success'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Iconsax.calendar_1,
                                    size: 10, color: Colors.white),
                              )),
                          const SizedBox(width: 8),
                          Text('24 May ', style: typography(context).smallBody),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Iconsax.clock,
                                    size: 10, color: Colors.white),
                              )),
                          const SizedBox(width: 8),
                          Text('10:00 AM - 12:00 PM',
                              style: typography(context).smallBody),
                        ],
                      ),
                    ),
                    const SizedBox(height: 0),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Iconsax.location,
                                    size: 10, color: Colors.white),
                              )),
                          const SizedBox(width: 8),
                          Text('Lodhi Garden, New Delhi',
                              style: typography(context).smallBody),
                          const Spacer(),
                          CupertinoButton(
                              child: Row(
                                children: [
                                  Text("Directions",
                                      style: typography(context)
                                          .smallBody
                                          .copyWith(
                                              color: colors(context)
                                                  .primary
                                                  .s500)),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.directions,
                                    size: 15,
                                  ),
                                ],
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                      left: 16, right: 0, top: 8, bottom: 8),
                  title: Text('Invite your friends',
                      style: typography(context).title3),
                  subtitle: Text('Share this event with your friends',
                      style: typography(context).smallBody),
                  trailing: Button(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: () {},
                    variant: 'text',
                    buttonColor: Colors.black,
                    buttonIcon: const Icon(Icons.ios_share_rounded),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About the event', style: typography(context).body),
                      const SizedBox(height: 16),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, vestibulum ligula sit amet, ultricies ex. Nullam nec nunc nec nunc ultricies ultricies. Nullam nec nunc nec nunc ultricies ultricies.',
                        style: typography(context).smallBody,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text('Terms and Conditions',
                      style: typography(context).body),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, vestibulum ligula sit amet, ultricies ex. Nullam nec nunc nec nunc ultricies ultricies. Nullam nec nunc nec nunc ultricies ultricies.',
                            style: typography(context).smallBody,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text('FAQs', style: typography(context).body),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, vestibulum ligula sit amet, ultricies ex. Nullam nec nunc nec nunc ultricies ultricies. Nullam nec nunc nec nunc ultricies ultricies.',
                            style: typography(context).smallBody,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              //need help chat w us
              Container(
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                      left: 16, right: 0, top: 8, bottom: 8),
                  title: Text('Need help? Chat with us',
                      style: typography(context).title3),
                  subtitle: Text('We are here to help you',
                      style: typography(context).smallBody),
                  trailing: Button(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: () {},
                    variant: 'text',
                    buttonColor: Colors.black,
                    buttonIcon: const Icon(Iconsax.message),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('More events like these',
                          style: typography(context).title3),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: 3,
                        padding: const EdgeInsets.only(left: 8, right: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(urlProvider.urlMap['assets/images/placeholders/pet_card_placeholder.png']!),
                                        
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          spreadRadius: 0,
                                          blurRadius: 18,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Event',
                                        style: typography(context).body),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
