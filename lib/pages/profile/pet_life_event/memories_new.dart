import 'package:flutter/material.dart';

class MemoriesNew extends StatefulWidget {
  const MemoriesNew({Key? key}) : super(key: key);

  @override
  State<MemoriesNew> createState() => _MemoriesNewState();
}

class _MemoriesNewState extends State<MemoriesNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: _buildProfileInfo(),
          ),
          SliverToBoxAdapter(
            child: _buildElement(
              "Description",
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const Text(
                    "There was never a patch of sun that Logan wasn’t to be found sleeping in! I’ve never known such a lazy yet loving cat.6 incredible years we shared together, you knew me better than I knew myself. Thank you for all the endless love. Miss you already."),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildElement(
                "Information",
                Container(
                  child: Column(
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
                )),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: MediaQuery.of(context).size.height * 0.29,
      collapsedHeight: MediaQuery.of(context).size.height * 0.29,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        centerTitle: true,
        title: Container(
          height: MediaQuery.of(context).size.height * 0.21,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/content/memories_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.26,
                top: MediaQuery.of(context).size.height * 0.1,
                bottom: 0,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.08,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/content/memories_pfp.png',
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      right: MediaQuery.of(context).size.width * 0.01,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xffe5BCF95),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.edit,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Add the text here
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.18,
                left: MediaQuery.of(context).size.width * 0.27,
                child: const Text(
                  'Logan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {},
      ),
      actions: [
        CircleAvatar(
          backgroundColor: const Color(0xffe5250e1),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'New York City',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Row(
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
            const SizedBox(width: 10),
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
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(Icons.info, color: Colors.grey),
                Text('Info'),
              ],
            ),
            SizedBox(width: 30),
            Column(
              children: [
                Icon(Icons.photo_album, color: Colors.grey),
                Text('Gallery'),
              ],
            ),
            SizedBox(width: 30),
            Column(
              children: [
                Icon(Icons.comment, color: Colors.grey),
                Text('Comment'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
