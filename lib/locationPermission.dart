import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class SwipeDownScreen extends StatelessWidget {
  const SwipeDownScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                // Swiped down
                Navigator.pop(context);
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Center(
                      child: Container(
                        width: 79,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child:  Text('Just one last thing',
                        style:
                            typography(context).strong.copyWith(fontSize: 15,
                            fontWeight: FontWeight.bold)),
                      ),
                    
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Please Enter the address so that we can find best available slots at your location',
                        style: typography(context).smallBody.copyWith(fontSize: 12),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 60)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'I understand',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                   Padding(padding: EdgeInsets.symmetric(vertical: 22))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
