import 'package:flutter/material.dart';

class Product {
  final String name;
  final int quantity;
  final String description;
  final String imageUrl; // Single image URL
  final double price; // Add price per unit for calculation

  Product({
    required this.name,
    required this.quantity,
    required this.description,
    required this.imageUrl, // Update to single image URL
    required this.price,
  });
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<String> imageUrls = [
    'assets/headphones.jpg', // Asset image URL
    'assets/headphones.jpg',
    'assets/headphones.jpg',
    'assets/headphones.jpg',
    'assets/headphones.jpg',
  ];

  Product product = Product(
    name: 'Headphones',
    quantity: 1,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    imageUrl: 'assets/headphones.jpg', // Asset image URL
    price: 599, // Price per unit
  );

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _pageController.addListener(_handlePageChange);
  }

  void _handlePageChange() {
    setState(() {
      _currentPage = _pageController.page!.round();
    });
  }

  void _incrementQuantity() {
    setState(() {
      product = Product(
        name: product.name,
        quantity: product.quantity + 1,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (product.quantity > 0) {
        product = Product(
          name: product.name,
          quantity: product.quantity - 1,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Keep horizontal padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200, // Keep height of the container
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0), // Rounded corners
                        child: Image.asset(imageUrls[index], width: 330, height: 200),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5), // Reduce the vertical spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < imageUrls.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 10, // Keep width of the slider indicator
                        height: 10, // Keep height of the slider indicator
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _currentPage ? Colors.blue : Colors.grey, // Active and inactive colors
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ), // Keep font size
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25.0), // Increase border radius
                      ),
                      child: Row(
                        children: [
                          GestureDetector(child: const Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(Icons.remove, size: 18,),
                          ), onTap: _decrementQuantity),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2), // Adjust horizontal padding
                            child: Text(
                              '${product.quantity}',
                              style: const TextStyle(fontSize: 14,fontFamily: 'Poppins',), // Reduce font size
                            ),
                          ),
                          GestureDetector(child: const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.add, size: 18,),
                          ), onTap: _incrementQuantity),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    const Text(
                      'Qty: ',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,fontFamily: 'Poppins',),
                    ),
                    Text(
                      '${product.quantity} Unit',
                      style: const TextStyle(fontSize: 15,fontFamily: 'Poppins',),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15), // Reduce the vertical spacing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.blue,
                                size: 16, // Keep icon size
                              ),
                              SizedBox(width: 4),
                              Text(
                                '4.7',
                                style: TextStyle(fontSize: 16, color: Colors.blue,fontFamily: 'Poppins',),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8), // Adjust horizontal spacing
                        const Text(
                          '230 reviews',
                          style: TextStyle(fontSize: 14, fontFamily: 'Poppins',),
                        ),
                      ],
                    ),
                    Text(
                      '₹${product.price * product.quantity}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top:25, left:8.0, right: 8.0, bottom: 8.0),
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins',),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  product.description,
                  style: const TextStyle(fontSize: 14,),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}