import 'dart:io';
import 'package:flutter/material.dart';

class PrePostOverview extends StatelessWidget {
  final String artisanName;
  final String artisanCategory;
  final String location;
  final String productName;
  final String productCategory;
  final String productDescription;
  final String productPrice;
  final String previewImagePath;

  const PrePostOverview({
    super.key,
    required this.artisanName,
    required this.artisanCategory,
    required this.location,
    required this.productName,
    required this.productCategory,
    required this.productDescription,
    required this.productPrice,
    required this.previewImagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isLocalFile = !previewImagePath.startsWith('http');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Post'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image preview
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: isLocalFile
                    ? Image.file(
                        File(previewImagePath),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        previewImagePath,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 30),
              // Artisan Info section
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/ios-filled/50/000000/user-male-circle.png'),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artisanName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        artisanCategory,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Product Details
              const Text("Product Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              const SizedBox(height: 10),
              Text(
                productName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                productCategory,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 15),
              Text(
                productDescription,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                "Price: INR $productPrice",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              // Buttons: Back and Publish
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Back"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Published!')));
                        // Add publishing logic here if needed
                      },
                      child: const Text("Publish"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
