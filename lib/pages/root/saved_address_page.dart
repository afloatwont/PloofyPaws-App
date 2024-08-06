import 'package:flutter/material.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SavedAddressPage extends StatefulWidget {
  const SavedAddressPage({super.key});

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  int? _selectedAddressIndex = 0;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userProvider = context.read<UserProvider>();
      userProvider.selectAddress(userProvider.user?.address?.first);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        userProvider.selectAddress(userProvider.user?.address?.first);
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addresses = context.read<UserProvider>().user?.address;
    final userProvider = context.read<UserProvider>();
    return Scaffold(
      body: addresses != null
          ? ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) => AddressCard(
                addresses[index],
                isSelected: index == _selectedAddressIndex,
                onTap: () {
                  userProvider.selectAddress(addresses[_selectedAddressIndex!]);
                  setState(() {
                    _selectedAddressIndex = index;
                  });
                },
              ),
            )
          : const Center(
              child: Text("No Saved Addresses"),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        child: TextButton(
          onPressed: _showAddressModal,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("+ Add Address"),
        ),
      ),
    );
  }

  void _showAddressModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: const AddAddressSheet(),
        );
      },
    );
  }
}

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressCard(
    this.address, {
    this.isSelected = false,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(14, 52, 168, 83)
              : Colors.transparent,
          border: Border.all(
            color:
                isSelected ? const Color(0xff34A853) : const Color(0xffEBEBEB),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  address.saveAs == 'Home' ? Icons.home : Icons.business,
                  color: isSelected ? const Color(0xff34A853) : Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  address.saveAs ?? '',
                  style: TextStyle(
                    color: isSelected ? const Color(0xff34A853) : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              userProvider.user!.displayName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userProvider.user!.email!,
            ),
            const SizedBox(height: 4),
            Text(
              address.getAddress(),
            ),
          ],
        ),
      ),
    );
  }
}
