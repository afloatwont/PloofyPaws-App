import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/services/repositories/memory/memory_provider.dart'; // Update with the correct path

class PhotosSection extends StatefulWidget {
  const PhotosSection({super.key});

  @override
  State<PhotosSection> createState() => _PhotosSectionState();
}

class _PhotosSectionState extends State<PhotosSection> {
  @override
  Widget build(BuildContext context) {
    final memoryProvider = Provider.of<MemoryProvider>(context);
    final memories = memoryProvider.memories;

    return Container(
      padding: const EdgeInsets.all(8.0), // Optional padding around the grid
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          crossAxisSpacing: 4.0, // Spacing between columns
          mainAxisSpacing: 4.0, // Spacing between rows
          childAspectRatio: 1.0, // Aspect ratio of each item (1:1 for square)
        ),
        itemCount: memories.length,
        itemBuilder: (context, index) {
          final memory = memories[index];
          final photoUrls = memory.photoUrls;

          if (photoUrls == null || photoUrls.isEmpty) {
            return const Center(
              child: Text('No Photos'),
            );
          }

          return Container(
            color: Colors.transparent,
            height: 50,
            width: 50,
            child: CachedNetworkImage(
              imageUrl: photoUrls[0], // Display the first photo URL
              placeholder: null,
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
