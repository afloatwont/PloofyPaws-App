import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/profile/records/pet_records.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/pet_model.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final imageUrl = context
            .read<UrlProvider>()
            .urlMap["assets/images/placeholders/pet_card_placeholder.png"] ??
        "";

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height:
                    widget.scale * MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: null,
                errorWidget: null,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  widget.pet.name ?? 'Unknown',
                  style: typography(context)
                      .ploofypawsTitle
                      .copyWith(color: Colors.amber),
                ),
                Button(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialWithModalsPageRoute(
                        builder: (context) => const PetRecords(),
                      ),
                    );
                  },
                  variant: 'text',
                  label: 'View Records',
                  buttonColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.pet.type ?? "Unknown type",
              style: typography(context).body.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.pet.breeds ?? "Unknown breeds",
                  textAlign: TextAlign.end,
                  style: typography(context)
                      .smallBody
                      .copyWith(color: Colors.white),
                ),
                Text(
                  widget.pet.gender ?? "Unknown gender",
                  textAlign: TextAlign.end,
                  style: typography(context)
                      .smallBody
                      .copyWith(color: Colors.white),
                ),
                Text(
                  getElapsedTime(widget.pet.dob ?? DateTime.now()),
                  textAlign: TextAlign.end,
                  style: typography(context)
                      .smallBody
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
