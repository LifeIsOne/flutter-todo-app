import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickFromGallery() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Test Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile == null
                ? const Text("이미지가 선택되지 않았습니다.")
                : SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.file(_imageFile!, fit: BoxFit.cover),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickFromGallery,
              child: const Text("갤러리에서 사진 선택"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickFromCamera,
              child: const Text("카메라로 촬영"),
            ),
          ],
        ),
      ),
    );
  }
}
