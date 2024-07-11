import 'package:flutter/material.dart';

class GroomingPackagesSection extends StatefulWidget {
  const GroomingPackagesSection({super.key});

  @override
  _GroomingPackagesSectionState createState() =>
      _GroomingPackagesSectionState();
}

class _GroomingPackagesSectionState extends State<GroomingPackagesSection> {
  int selectedIndex = 1; // Initially select the recommended package
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> packages = [
    {
      'title': 'Grooming',
      'description': 'Save 45%',
      'price': 'Rs. 1899',
      'originalPrice': 'Rs. 2299',
      'isRecommended': false,
      'headerText': 'Best Value',
    },
    {
      'title': 'Training',
      'description': 'Save 30%',
      'price': 'Rs. 1399',
      'originalPrice': 'Rs. 1999',
      'isRecommended': true,
      'headerText': 'Recommended',
    },
    {
      'title': 'Grooming',
      'description': 'Save 25%',
      'price': 'Rs. 1129',
      'originalPrice': 'Rs. 1499',
      'isRecommended': false,
      'headerText': 'Best Value',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerSelectedPackage();
    });
  }

  void _centerSelectedPackage() {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth * 0.40; // Increased the item width
    double scrollPosition =
        (itemWidth + 34) * selectedIndex - (screenWidth / 2 - itemWidth / 2);
    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(packages.length, (index) {
                    return GroomingPackageCard(
                      title: packages[index]['title'],
                      description: packages[index]['description'],
                      price: packages[index]['price'],
                      originalPrice: packages[index]['originalPrice'],
                      isRecommended: selectedIndex == index,
                      headerText: packages[index]['headerText'],
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        _centerSelectedPackage();
                      },
                      isSelected: selectedIndex == index,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // background color
                    foregroundColor: Colors.white, // text color
                    fixedSize: Size(double.maxFinite,
                        MediaQuery.sizeOf(context).height * 0.06)),
                child: const Text("Select Package"),
              ),
              const SizedBox(height: 24),
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
  final VoidCallback onTap;
  final bool isSelected;

  const GroomingPackageCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.isRecommended,
    required this.headerText,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 8),
        width: isSelected
            ? MediaQuery.sizeOf(context).width *
                0.48 // Increased selected width
            : MediaQuery.sizeOf(context).width * 0.36,
        height: isSelected
            ? MediaQuery.sizeOf(context).height *
                0.42 // Increased selected height
            : MediaQuery.sizeOf(context).height * 0.36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isRecommended ? Colors.purple : Colors.grey.shade50,
            width: isRecommended ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Explore  ",
                    style: TextStyle(
                      fontSize: isSelected
                          ? 16
                          : 14, // Set font size based on isSelected
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
