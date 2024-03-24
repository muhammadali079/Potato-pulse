import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disease/custom_widgets/custom_button.dart';

class ToolScreen extends StatefulWidget {
  const ToolScreen({super.key});

  @override
  State<ToolScreen> createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  Uint8List? _imageBytes;
  Future<void> _openFileManager(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tool Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pics/12.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 500,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: const Color.fromARGB(255, 8, 65, 27),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          image: const DecorationImage(
                            image: AssetImage('assets/pics/icon.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: const Text(
                          'Potato Disease\nDetection',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 18, 18, 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Image(
                        image: AssetImage(
                          'assets/pics/icon.jpg',
                        ),
                        width: 100,
                        height: 0,
                      ),
                      const Center(
                        child: Text(
                          "Supporting Farmers in\nSafguarding their Crops Heatlh",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_imageBytes != null)
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: MemoryImage(_imageBytes!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 40),
                            ),
                            const Text(
                              "No image selected",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: 'Import to Device',
                              onPressed: () => _openFileManager(context),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
