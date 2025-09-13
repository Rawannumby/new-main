import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'pre_post_overview.dart';  // Import the preview screen
import 'story_generating_page.dart'; // Your existing voice recording screen

class UploadPage extends StatefulWidget {
	final String? artisanName;
	final String? artisanCategory;
	final String? location;

	const UploadPage({
		super.key,
		this.artisanName,
		this.artisanCategory,
		this.location,
	});
	@override
	State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
	File? _image;
	final picker = ImagePicker();

	String productName = '';
	String artworkDesc = '';
	String yourPrice = '';

	// These can be either fixed or dynamically fetched
	final String detectedCategory = "Ceramic, Paint";
	final String predictedPrice = "₹2500";

	Future<void> _pickImage() async {
		final pickedFile = await picker.pickImage(
			source: ImageSource.gallery,
			imageQuality: 80,
		);
		if (pickedFile != null) {
			setState(() {
				_image = File(pickedFile.path);
			});
		}
	}

	void _onVoiceAssistantTap() {
		Navigator.push(
			context,
			MaterialPageRoute(builder: (_) => const StoryGeneratingPage()),
		);
	}

	void _onUpload() {
		if (productName.trim().isEmpty || artworkDesc.trim().isEmpty || yourPrice.trim().isEmpty) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(content: Text('Please fill in all fields')),
			);
			return;
		}

		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => PrePostOverview(
					artisanName: widget.artisanName ?? 'Anonymous Artist',
					artisanCategory: widget.artisanCategory ?? 'Artisan',
					location: widget.location ?? 'India',
					productName: productName,
					productCategory: detectedCategory,
					productDescription: artworkDesc,
					previewImagePath: _image?.path ?? 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600',
					productPrice: yourPrice,
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: const Color(0xFFF7F9FC),
			body: SafeArea(
				child: SingleChildScrollView(
					padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							// App bar with close and title
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									IconButton(
										icon: const Icon(Icons.close, size: 26),
										onPressed: () => Navigator.pop(context),
									),
									const Text(
										"Upload",
										style: TextStyle(
												fontWeight: FontWeight.bold,
												fontSize: 18,
												color: Color(0xFF0C141C)),
									),
									const SizedBox(width: 44),
								],
							),
							const SizedBox(height: 10),
							// Large product image or placeholder rounded
							GestureDetector(
								onTap: _pickImage,
								child: ClipRRect(
									borderRadius: BorderRadius.circular(16),
									child: _image != null
											? Image.file(
										_image!,
										height: 170,
										width: double.infinity,
										fit: BoxFit.cover,
									)
											: Image.network(
										'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
										height: 170,
										width: double.infinity,
										fit: BoxFit.cover,
									),
								),
							),
							const SizedBox(height: 20),
							// Product Name
							const Text(
								"Product Name",
								style: TextStyle(
										color: Color(0xFF0C141C),
										fontWeight: FontWeight.bold,
										fontSize: 15),
							),
							const SizedBox(height: 7),
							Container(
								decoration: BoxDecoration(
									color: const Color(0xFFE8EDF4),
									borderRadius: BorderRadius.circular(11),
								),
								child: TextField(
									onChanged: (val) => setState(() => productName = val),
									decoration: const InputDecoration(
										hintText: 'Enter product name',
										hintStyle: TextStyle(color: Color(0xFF97A1B2)),
										border: InputBorder.none,
										contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
									),
									style: const TextStyle(color: Color(0xFF49729B), fontSize: 16),
								),
							),
							const SizedBox(height: 18),
							// Describe your artwork
							const Text("Describe your artwork",
									style: TextStyle(
											fontWeight: FontWeight.bold,
											fontSize: 15,
											color: Color(0xFF0C141C))),
							const SizedBox(height: 7),
							Container(
								decoration: BoxDecoration(
									color: const Color(0xFFE8EDF4),
									borderRadius: BorderRadius.circular(11),
								),
								child: TextField(
									maxLines: 4,
									onChanged: (val) => setState(() => artworkDesc = val),
									decoration: const InputDecoration(
										hintText: "Describe your artwork",
										hintStyle: TextStyle(color: Color(0xFF97A1B2)),
										border: InputBorder.none,
										contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
									),
									style: const TextStyle(color: Color(0xFF49729B), fontSize: 16),
								),
							),
							const SizedBox(height: 12),
							// Voice Assistant: Icon above button
							Center(
								child: Column(
									children: [
										InkWell(
											onTap: _onVoiceAssistantTap,
											borderRadius: BorderRadius.circular(20),
											child: Container(
												width: 36,
												height: 36,
												decoration: BoxDecoration(
													color: const Color(0xFFE8EDF4),
													shape: BoxShape.circle,
												),
												child: const Icon(
													Icons.mic_none,
													color: Color(0xFF49729B),
													size: 22,
												),
											),
										),
										const SizedBox(height: 5),
										const Text(
											"Voice Assistant",
											style: TextStyle(
												color: Color(0xFF0C141C),
												fontWeight: FontWeight.w500,
												fontSize: 13,
											),
										),
									],
								),
							),
							const SizedBox(height: 24),
							// Category
							const Text(
								"Category",
								style: TextStyle(
									fontWeight: FontWeight.bold,
									fontSize: 15,
									color: Color(0xFF0C141C),
								),
							),
							const SizedBox(height: 7),
							Container(
								decoration: BoxDecoration(
									color: const Color(0xFFE8EDF4),
									borderRadius: BorderRadius.circular(11),
								),
								alignment: Alignment.centerLeft,
								height: 36,
								width: 120,
								padding: const EdgeInsets.symmetric(horizontal: 14),
								child: Text(
									detectedCategory,
									style: const TextStyle(
										color: Color(0xFF49729B),
										fontSize: 16,
									),
								),
							),
							const SizedBox(height: 14),
							// AI Assistant note
							const Text(
								"Our AI assistant suggests a price based on your art's characteristics and market trends.",
								style: TextStyle(
									color: Color(0xFF444B58),
									fontSize: 14,
								),
							),
							const SizedBox(height: 16),
							// Suggested Price (muted rectangle)
							const Text(
								"Suggested Price",
								style: TextStyle(
										color: Color(0xFF0C141C),
										fontWeight: FontWeight.bold,
										fontSize: 15),
							),
							const SizedBox(height: 7),
							Container(
								decoration: BoxDecoration(
									color: const Color(0xFFE8EDF4),
									borderRadius: BorderRadius.circular(11),
								),
								alignment: Alignment.center,
								height: 36,
								width: 120,
								child: Text(
									predictedPrice,
									style: const TextStyle(
										color: Color(0xFF49729B),
										fontSize: 16,
									),
								),
							),
							const SizedBox(height: 18),
							// Your Price (input box)
							const Text(
								"Your Price",
								style: TextStyle(
										color: Color(0xFF0C141C),
										fontWeight: FontWeight.bold,
										fontSize: 15),
							),
							const SizedBox(height: 7),
							Container(
								decoration: BoxDecoration(
									color: const Color(0xFFE8EDF4),
									borderRadius: BorderRadius.circular(11),
								),
								child: TextField(
									keyboardType: TextInputType.number,
									onChanged: (val) => setState(() => yourPrice = val),
									decoration: const InputDecoration(
										hintText: "Enter your price",
										hintStyle: TextStyle(color: Color(0xFF97A1B2)),
										border: InputBorder.none,
										contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
									),
									style: const TextStyle(color: Color(0xFF49729B), fontSize: 16),
								),
							),
							const SizedBox(height: 28),
							// Upload button
							SizedBox(
								width: double.infinity,
								child: ElevatedButton(
									onPressed: _onUpload,
									style: ElevatedButton.styleFrom(
										elevation: 0,
										backgroundColor: const Color(0xFF3D99F4),
										shape: RoundedRectangleBorder(
												borderRadius: BorderRadius.circular(11)),
										padding: const EdgeInsets.symmetric(vertical: 16),
									),
									child: const Text(
										"Upload",
										style: TextStyle(
												color: Colors.white,
												fontWeight: FontWeight.w600,
												fontSize: 16),
									),
								),
							),
							const SizedBox(height: 16),
						],
					),
				),
			),
		);
	}
}
