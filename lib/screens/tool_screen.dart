import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disease/custom_widgets/custom_button.dart';

class ToolScreen extends StatefulWidget {
  const ToolScreen({super.key});

  @override
  State<ToolScreen> createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  Uint8List? _imageBytes;
  String? _predictedClass;

  // Future<void> _getImage() async {
  //   FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();

  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageBytes = pickedFile.files.first;
  //     });
  //   }
  // }
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

  Future<void> _simulateApiCall() async {
    print('inside api function');
    try {
      final uri =
          Uri.parse('https://6daf-14-192-132-165.ngrok-free.app/testing');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          _imageBytes!,
          filename: 'image.jpg',
        ));
      // final uri = Uri.parse('http://127.0.0.1:5000/test');
      //var request = http.MultipartRequest('POST', uri);
      var response = await request.send();

      if (response.statusCode == 200) {
        print("Status response 200");
        var decodedResponse = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(decodedResponse);
        print('json data: $jsonResponse');
        print(jsonDecode(decodedResponse)['prediction_class']);
        setState(() {
          _predictedClass = jsonDecode(decodedResponse)['prediction_class'];
        });
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _predictedClass = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tool Screen'),
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
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: const Color.fromARGB(255, 8, 65, 27),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                      "Supporting Farmers in\nSafeguarding their Crops Health",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_imageBytes != null)
                    Column(children: [
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
                      ),
                      CustomButton(
                        text: 'Upload',
                        onPressed: () => _simulateApiCall(),
                      ),
                      Text(
                        "$_predictedClass",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                       CustomButton(
                        text: 'Reset',
                        onPressed: (){
                          setState(() {
                            _imageBytes = null;
                            _predictedClass = '';
                          });
                        },
                      ),

                    ])
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
                          text: 'Import from Device',
                          onPressed: () => _openFileManager(context),
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
