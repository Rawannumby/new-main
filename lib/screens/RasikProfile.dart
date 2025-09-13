import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'latest_artwork.dart';
import 'SearchPage.dart';

class RasikProfile extends StatefulWidget {
  const RasikProfile({super.key});
  @override
  RasikProfileState createState() => RasikProfileState();
}

class RasikProfileState extends State<RasikProfile> {
  File? _profileImage;
  String _name = "Priya Sharma";
  String _bio = "Art Enthusiast · Joined 2021";
  String _about = "Passionate about discovering and supporting emerging artists. I love exploring different art forms and connecting with creators.";

  // Dummy favorite artworks
  final List<Map<String, String>> _favorites = [
    {
      "title": "Vibrant Landscapes",
      "artist": "Anika Verma",
      "image": "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/uhjLWlJxTl/b5j8w8cl_expires_30_days.png"
    },
    {
      "title": "Modern Sculptures",
      "artist": "Rohan Kapoor",
      "image": "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/uhjLWlJxTl/0v9m425q_expires_30_days.png"
    },
    {
      "title": "Handcrafted Pottery",
      "artist": "Meera Patel",
      "image": "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/uhjLWlJxTl/zmrgubhe_expires_30_days.png"
    },
  ];

  // Open image picker
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() => _profileImage = File(pickedFile.path));
    }
  }

  // Navigate to edit profile page
  Future<void> _editProfile() async {
    final updated = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(name: _name, bio: _about),
      ),
    );
    if (updated != null) {
      setState(() {
        _name = updated["name"] ?? _name;
        _about = updated["bio"] ?? _about;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFFFFFFF),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: SizedBox(
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IntrinsicHeight(
                                      child: Container(
                                        color: const Color(0xFFFFFFFF),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            IntrinsicHeight(
                                              child: Container(
                                                color: const Color(0xFFFFFFFF),
                                                padding: const EdgeInsets.only(top: 16, bottom: 16, left: 64, right: 16),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Profile",
                                                          style: TextStyle(
                                                            color: const Color(0xFF161411),
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    // Settings Icon
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFF5F5F5),
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.settings,
                                                          size: 24,
                                                          color: const Color(0xFF161411),
                                                        ),
                                                        onPressed: () {
                                                          // Add settings functionality here
                                                          print("Settings button pressed");
                                                        },
                                                        padding: EdgeInsets.zero,
                                                        splashRadius: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            IntrinsicHeight(
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Column(
                                                          children: [
                                                            Center(
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    margin: const EdgeInsets.only(bottom: 16),
                                                                    width: 128,
                                                                    height: 128,
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: Colors.orange.shade100,
                                                                      image: _profileImage != null
                                                                          ? DecorationImage(
                                                                              image: FileImage(_profileImage!),
                                                                              fit: BoxFit.cover,
                                                                            )
                                                                          : const DecorationImage(
                                                                              image: NetworkImage(
                                                                                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/uhjLWlJxTl/u2bmmm7s_expires_30_days.png"),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: 0,
                                                                    right: 0,
                                                                    child: InkWell(
                                                                      onTap: _pickImage,
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.orange,
                                                                          shape: BoxShape.circle,
                                                                          border: Border.all(width: 3, color: Colors.white),
                                                                        ),
                                                                        padding: const EdgeInsets.all(6),
                                                                        child: const Icon(
                                                                          Icons.camera_alt_rounded,
                                                                          color: Colors.white,
                                                                          size: 20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            IntrinsicWidth(
                                                              child: IntrinsicHeight(
                                                                child: Column(
                                                                  children: [
                                                                    IntrinsicWidth(
                                                                      child: IntrinsicHeight(
                                                                        child: Container(
                                                                          padding: const EdgeInsets.only(bottom: 1),
                                                                          child: Column(
                                                                            children: [
                                                                              Text(
                                                                                _name,
                                                                                style: TextStyle(
                                                                                  color: const Color(0xFF161411),
                                                                                  fontSize: 22,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    IntrinsicWidth(
                                                                      child: IntrinsicHeight(
                                                                        child: Container(
                                                                          padding: const EdgeInsets.only(bottom: 1),
                                                                          child: Column(
                                                                            children: [
                                                                              Text(
                                                                                "Art Enthusiast",
                                                                                style: TextStyle(
                                                                                  color: const Color(0xFF897060),
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    IntrinsicWidth(
                                                                      child: IntrinsicHeight(
                                                                        child: Container(
                                                                          padding: const EdgeInsets.only(bottom: 1),
                                                                          child: Column(
                                                                            children: [
                                                                              Text(
                                                                                "Joined 2021",
                                                                                style: TextStyle(
                                                                                  color: const Color(0xFF897060),
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(height: 12),
                                                                    ElevatedButton(
                                                                      onPressed: _editProfile,
                                                                      style: ElevatedButton.styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                        ),
                                                                      ),
                                                                      child: const Text("Edit Profile"),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                                              child: Text(
                                                "About",
                                                style: TextStyle(
                                                  color: const Color(0xFF161411),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                              width: double.infinity,
                                              child: Text(
                                                _about,
                                                style: TextStyle(
                                                  color: const Color(0xFF161411),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                                              child: Text(
                                                "Favorites",
                                                style: TextStyle(
                                                  color: const Color(0xFF161411),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 195,
                                              child: ListView.separated(
                                                scrollDirection: Axis.horizontal,
                                                physics: const ClampingScrollPhysics(),
                                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                                itemCount: _favorites.length,
                                                itemBuilder: (_, index) {
                                                  final fav = _favorites[index];
                                                  return Container(
                                                    width: 160,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          width: 160,
                                                          height: 135,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(8),
                                                            child: Image.network(
                                                              fav["image"]!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 6),
                                                        Text(
                                                          fav["title"]!,
                                                          style: TextStyle(
                                                            color: const Color(0xFF161411),
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          "By ${fav["artist"]!}",
                                                          style: TextStyle(
                                                            color: const Color(0xFF897060),
                                                            fontSize: 11,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (_, __) =>
                                                    const SizedBox(width: 16),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: 2,
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LatestArtwork()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              } else {
                // Stay on the current page
              }
            },
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 28),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 28),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 28),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Edit Profile Page --------------------

class EditProfilePage extends StatefulWidget {
  final String name;
  final String bio;

  const EditProfilePage({super.key, required this.name, required this.bio});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.name);
    _bioCtrl = TextEditingController(text: widget.bio);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _saveProfile() {
    Navigator.pop(context, {
      "name": _nameCtrl.text.trim(),
      "bio": _bioCtrl.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _bioCtrl,
              decoration: const InputDecoration(labelText: "Bio / About"),
              minLines: 2,
              maxLines: 4,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Save",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
