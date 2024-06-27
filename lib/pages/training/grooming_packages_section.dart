import 'package:flutter/material.dart';

class GroomingPackagesSection extends StatelessWidget {
  const GroomingPackagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Grooming Packages',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.sizeOf(context).height * 0.58,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GroomingPackageCard(
                      title: 'Grooming',
                      description: 'Save 45%',
                      price: 'Rs. 1899',
                      originalPrice: 'Rs. 2299',
                      isRecommended: false,
                      headerText: 'Best Value',
                    ),
                    GroomingPackageCard(
                      title: 'Training',
                      description: 'Save 30%',
                      price: 'Rs. 1399',
                      originalPrice: 'Rs. 1999',
                      isRecommended: true,
                      headerText: 'Recommended',
                    ),
                    GroomingPackageCard(
                      title: 'Grooming',
                      description: 'Save 25%',
                      price: 'Rs. 1129',
                      originalPrice: 'Rs. 1499',
                      isRecommended: false,
                      headerText: 'Best Value',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // background color
                    foregroundColor: Colors.white, // text color
                    fixedSize: Size(double.maxFinite,
                        MediaQuery.sizeOf(context).height * 0.065)),
                child: const Text("Select Package"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class GroomingPackageCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String originalPrice;
  final bool isRecommended;
  final String headerText;

  const GroomingPackageCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.isRecommended,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle card tap
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: MediaQuery.sizeOf(context).width * 0.36,
        height: MediaQuery.sizeOf(context).height * 0.36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isRecommended ? Colors.purple : Colors.grey.shade50,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isRecommended ? Colors.purple : Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              child: Text(
                headerText,
                style: TextStyle(
                  color: isRecommended ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/placeholders/ai_pets_card.png',
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      originalPrice,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      price,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Explore  "),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
