import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File? _selectedImage;
  bool _isSaving = false;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _saveProduct() async {
    if (_selectedImage == null) {
      // 선택된 이미지가 없으면 기본 이미지로 저장
      final defaultImagePath = 'images/logo.png';
      _selectedImage = File(defaultImagePath);
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('product_images');
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final uploadTask = storageRef.child('$imageName.png').putFile(_selectedImage!);
      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();

      // TODO: 데이터베이스에 제품 정보 및 이미지 URL 저장 로직 추가

      setState(() {
        _isSaving = false;
      });

      // 성공적으로 저장되었음을 알리는 메시지 출력
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Product saved successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // AddPage를 닫고 이전 페이지로 이동
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      // 저장 실패 시 오류 메시지 출력
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to save product. Error: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : Image.asset('images/logo.png'), // 기본 이미지 출력
            ElevatedButton(
              onPressed: _pickImage, // 이미지 선택 기능
              child: const Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: _isSaving ? null : _saveProduct, 
              child: _isSaving ? const CircularProgressIndicator() : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
