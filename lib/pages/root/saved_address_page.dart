import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SavedAddressPage extends StatelessWidget {
  const SavedAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = context.read<UserProvider>().user?.address;
    return Scaffold(
      body: addresses != null
          ? ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) => _buildCard(
                addresses[index],
              ),
            )
          : const Center(
              child: Text("No Saved Addresses"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCard(AddressModel address) {
    return Container();
  }
}
