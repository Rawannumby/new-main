import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'landing_screen.dart'; // Adjust import path as needed

import 'SearchPage.dart';
import 'depth0_frame0_screen.dart';
import 'RasikProfile.dart'; // Import the RasikProfile page

class LatestArtwork extends StatefulWidget {
  const LatestArtwork({super.key});

  @override
  State<LatestArtwork> createState() => _LatestArtworkState();
}

class _LatestArtworkState extends State<LatestArtwork> {
  int _selectedIndex = 0;

  void _onNavTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RasikProfile()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onProductTap(Map<String, dynamic> productData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Depth0Frame0(productData: productData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Top bar with avatar and settings
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/6rzwd616_expires_30_days.png",
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: Colors.black54,
                      size: 26,
                    ),
                    onSelected: (value) async {
                      if (value == 'sign_out') {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => LandingScreen(
                              onNavigateToLogin: () {},
                            ),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'sign_out',
                          child: Text('Sign Out'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Latest Artworks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            
            // Artwork cards
            _artworkCard(
              image:
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/bm9srn9f_expires_30_days.png",
              title: "Ceramic Vase",
              desc: "Handcrafted ceramic vase with intricate floral patterns.",
              artist: "Anya Sharma",
              likeCount: "234",
              commentCount: "120",
              iconLeft: Icons.favorite_border,
              iconRight: Icons.bookmark_border,
              onTap: () {
                _onProductTap({
                  'image':
                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/bm9srn9f_expires_30_days.png",
                  'title': "Ceramic Vase",
                  'desc':
                      "Handcrafted ceramic vase with intricate floral patterns.",
                  'artist': "Anya Sharma",
                  'likeCount': "234",
                  'commentCount': "120",
                });
              },
            ),
            _artworkCard(
              image:
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/dzofg6nq_expires_30_days.png",
              title: "Wooden Sculpture",
              desc: "Detailed wooden sculpture of a mythical creature.",
              artist: "Rohan Verma",
              likeCount: "187",
              commentCount: "95",
              iconLeft: Icons.favorite_border,
              iconRight: Icons.bookmark_border,
              onTap: () {
                _onProductTap({
                  'image':
                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/dzofg6nq_expires_30_days.png",
                  'title': "Wooden Sculpture",
                  'desc': "Detailed wooden sculpture of a mythical creature.",
                  'artist': "Rohan Verma",
                  'likeCount': "187",
                  'commentCount': "95",
                });
              },
            ),
            _artworkCard(
              image:
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/kri0ziim_expires_30_days.png",
              title: "Embroidered Textile",
              desc: "Vibrant embroidered textile depicting a traditional scene.",
              artist: "Kavya Patel",
              likeCount: "210",
              commentCount: "112",
              iconLeft: Icons.favorite_border,
              iconRight: Icons.bookmark_border,
              onTap: () {
                _onProductTap({
                  'image':
                      "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/kri0ziim_expires_30_days.png",
                  'title': "Embroidered Textile",
                  'desc': "Vibrant embroidered textile depicting a traditional scene.",
                  'artist': "Kavya Patel",
                  'likeCount': "210",
                  'commentCount': "112",
                });
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
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
    );
  }

  Widget _artworkCard({
    required String image,
    required String title,
    required String desc,
    required String artist,
    required String likeCount,
    required String commentCount,
    required IconData iconLeft,
    required IconData iconRight,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                height: 148,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              desc,
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 15.0,
                height: 1.4,
              ),
            ),
            Text(
              "by $artist",
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 15.0,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Icon(
                  iconLeft,
                  color: const Color(0xFFB0AAA4),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  likeCount,
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20),
                Icon(
                  iconRight,
                  color: const Color(0xFFB0AAA4),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  commentCount,
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
