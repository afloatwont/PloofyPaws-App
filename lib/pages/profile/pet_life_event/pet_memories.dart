import 'package:flutter/material.dart';

class PetMemories extends StatefulWidget {
  const PetMemories({super.key});

  @override
  State<PetMemories> createState() => _PetMemoriesState();
}

class _PetMemoriesState extends State<PetMemories> {
  int _selectedIndex = 0;

  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeaderSection(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTitleSection(),
                      _buildLocationRow(),
                      const SizedBox(height: 15),
                      _buildActionButtons(),
                      const SizedBox(height: 20),
                      _buildTabButtons(),
                      _buildSelectedContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.26,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/content/memories_bg.png"),
          alignment: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 25,
            left: 10,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 25,
            right: 10,
            child: IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          Positioned(
            right: MediaQuery.sizeOf(context).width * 0.38,
            bottom: MediaQuery.sizeOf(context).height * 0.01,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  child: Image.asset(
                    "assets/images/content/memories_pfp.png",
                  ),
                ),
                Positioned(
                  top: 55,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.greenAccent.shade400,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return const Text(
      "Logan",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLocationRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.pin_drop_outlined, color: Colors.red),
        SizedBox(width: 10),
        Text("New York City"),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: OutlinedButton.icon(
            icon: const Icon(Icons.share),
            label: const Text(
              'Public Page',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 15),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: OutlinedButton.icon(
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
            ),
            label: const Text(
              'Update Page',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildTabButtons() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () => _onButtonTapped(0),
            label: Text(
              "Info",
              style: TextStyle(
                color: _selectedIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            icon: Icon(
              Icons.pets_outlined,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedIndex == 0 ? Colors.blue : Colors.grey.shade200,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _onButtonTapped(1),
            label: Text(
              "Gallery",
              style: TextStyle(
                color: _selectedIndex == 1 ? Colors.white : Colors.black,
              ),
            ),
            icon: Icon(
              Icons.image,
              color: _selectedIndex == 1 ? Colors.white : Colors.black,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedIndex == 1 ? Colors.blue : Colors.grey.shade200,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _onButtonTapped(2),
            label: Text(
              "Comment",
              style: TextStyle(
                color: _selectedIndex == 2 ? Colors.white : Colors.black,
              ),
            ),
            icon: Icon(
              Icons.comment,
              color: _selectedIndex == 2 ? Colors.white : Colors.black,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedIndex == 2 ? Colors.blue : Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedIndex) {
      case 1:
        return const Center(
          child: Text(
            "Photos and Videos",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w100),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            "Comments",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w100),
          ),
        );
      default:
        return Column(
          children: [
            _buildElement(
              "Description",
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                    "There was never a patch of sun that Logan wasn’t to be found sleeping in! I’ve never known such a lazy yet loving cat.6 incredible years we shared together, you knew me better than I knew myself. Thank you for all the endless love. Miss you already."),
              ),
            ),
            _buildElement(
              "Information",
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInfoRow('Name:', 'Logan'),
                  _buildInfoRow('Born:', '23/11/2006'),
                  _buildInfoRow('Gender:', 'Female'),
                  _buildInfoRow('Breed:', 'Maine Coon'),
                  _buildInfoRow('Favourite toy:', 'Dog scratcher'),
                  _buildInfoRow(
                      'Habits:', 'Sleeping on face, cuddling, scratching'),
                  _buildInfoRow(
                      'Characteristics:', 'Loving, Affectionate, Moody'),
                  _buildInfoRow('Favourite food:', 'Purina One'),
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget _buildHeader(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        CircleAvatar(
          backgroundColor: const Color(0xffe5250e1),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildElement(String label, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHeader(label),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
