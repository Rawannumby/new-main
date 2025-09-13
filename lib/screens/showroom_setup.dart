import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'digital_personal_dashboard.dart';
import 'upload_page.dart';

class ShowroomSetup extends StatefulWidget {
  const ShowroomSetup({super.key});

  @override
  State<ShowroomSetup> createState() => _ShowroomSetupState();
}

class _ShowroomSetupState extends State<ShowroomSetup> {
  XFile? _profileImage;
  String _artistName = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  String _businessName = '';
  String _businessEmail = '';
  String _businessPhone = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  void _handleVoiceInput() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice assistant feature coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle =
    const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0C0F1C));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Showroom Setup',
          style: TextStyle(
              color: Color(0xFF0C0F1C), fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickProfileImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 56,
                    backgroundColor: const Color(0xFFE5E8F4),
                    backgroundImage: _profileImage != null
                        ? FileImage(File(_profileImage!.path))
                        : const NetworkImage(
                            'https://storage.googleapis.com/tagjs-prod.appspot.com/v1/BSML5JvnyV/bwaij4n0_expires_30_days.png',
                          ) as ImageProvider,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  filled: true,
                  fillColor: Color(0xFFE5E8F4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0C0F1C)),
                onChanged: (val) => setState(() => _artistName = val),
              ),
            ),
            if (_artistName.isNotEmpty)
              Text(
                '@${_artistName.trim().toLowerCase().replaceAll(' ', '')}',
                style: const TextStyle(color: Color(0xFF47569E), fontSize: 16),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Artist's Story", style: labelStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Stack(
                children: [
                  TextField(
                    controller: _storyController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Tell us about your artistic journey",
                      filled: true,
                      fillColor: Color(0xFFE5E8F4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleVoiceInput,
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.mic, color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Business Details (Optional)", style: labelStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  _buildBusinessField("Business Name", _businessName, (val) => setState(() => _businessName = val)),
                  const SizedBox(height: 12),
                  _buildBusinessField("Business Email", _businessEmail, (val) => setState(() => _businessEmail = val), keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 12),
                  _buildBusinessField("Business Phone", _businessPhone, (val) => setState(() => _businessPhone = val), keyboardType: TextInputType.phone),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DigitalPersonalDashboard(
                                  profileName: _artistName,
                                  profileImagePath: _profileImage?.path,
                                  profileEmail: _businessEmail,
                                  artistStory: _storyController.text,
                                  businessName: _businessName,
                                  businessPhone: _businessPhone,
                                )));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UploadPage(
                              artisanName: _artistName,
                              artisanCategory: 'Artisan',
                              location: 'India',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Upload Your Art",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  Widget _buildBusinessField(String hint, String value, Function(String) onChanged, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFE5E8F4),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16)
      ),
      onChanged: onChanged,
    );
  }
}
