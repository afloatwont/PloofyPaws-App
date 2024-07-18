import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/profile/records/pet_records.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/pet_model.dart';

class PetCard extends StatefulWidget {
  final Pet pet;
  final double scale;

  const PetCard({
    super.key,
    required this.pet,
    required this.scale,
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  String getElapsedTime(DateTime dob) {
    DateTime now = DateTime.now();

    int yearsDifference = now.year - dob.year;
    int monthsDifference = now.month - dob.month;
    int daysDifference = now.day - dob.day;

    if (daysDifference < 0) {
      monthsDifference--;
      daysDifference += DateTime(now.year, now.month, 0).day;
    }

    if (monthsDifference < 0) {
      yearsDifference--;
      monthsDifference += 12;
    }

    if (yearsDifference > 0) {
      return '$yearsDifference years ${monthsDifference > 0 ? "$monthsDifference months" : ""}';
    } else if (monthsDifference > 0) {
      return '$monthsDifference months';
    } else {
      return '$daysDifference days';
    }
  }

  String? imageUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageUrl("assets/images/placeholders/pet_card_placeholder.png").then(
      (value) => setState(() {
        imageUrl = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // child: FutureBuilder(
              //     future: getImageUrl(
              //         "assets/images/placeholders/pet_card_placeholder.png"),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const Center(
              //           child: LinearProgressIndicator(
              //               color: Colors.white, backgroundColor: Colors.grey),
              //         );
              //       } else if (snapshot.hasError) {
              //         return const Center(
              //           child: Text('Error loading'),
              //         ); // Handle any errors
              //       } else if (!snapshot.hasData) {
              //         return const Center(
              //           child: Text('No data available'),
              //         ); // Handle the case where there's no data
              //       } else {
              //         return CachedNetworkImage(
              //           imageUrl: snapshot.data!,
              //           height: widget.scale *
              //               MediaQuery.of(context).size.height *
              //               0.35,
              //           width: double.infinity,
              //           fit: BoxFit.cover,
              //           imageBuilder: (context, imageProvider) =>
              //               Image(image: imageProvider, fit: BoxFit.cover),
              //         );
              //       }
              //     }),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                height:
                    widget.scale * MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    const LinearProgressIndicator(
                        color: Colors.black, backgroundColor: Colors.black87),
                placeholder: (context, url) => const LinearProgressIndicator(
                    color: Colors.black, backgroundColor: Colors.black87),
                imageBuilder: (context, imageProvider) =>
                    Image(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(widget.pet.name!,
                    style: typography(context)
                        .ploofypawsTitle
                        .copyWith(color: Colors.amber)),
                Button(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialWithModalsPageRoute(
                            builder: (context) => const PetRecords()));
                  },
                  variant: 'text',
                  label: 'View Records',
                  buttonColor: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(widget.pet.type ?? "",
                style: typography(context).body.copyWith(color: Colors.white)),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.pet.breeds ?? "",
                    textAlign: TextAlign.end,
                    style: typography(context)
                        .smallBody
                        .copyWith(color: Colors.white)),
                Text(widget.pet.gender ?? "",
                    textAlign: TextAlign.end,
                    style: typography(context)
                        .smallBody
                        .copyWith(color: Colors.white)),
                Text(getElapsedTime(widget.pet.dob!),
                    textAlign: TextAlign.end,
                    style: typography(context)
                        .smallBody
                        .copyWith(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
