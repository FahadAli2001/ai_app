 
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String selectedItem = '';
  late File pickedImage;
  var imageFile;
  var result = '';
  bool isImageLoaded = false;
  bool isFaceDetected = false;
  List<Rect> rect = [];

  Future getImageFromGallery() async {
    var tempStore = await ImagePicker().pickImage(source: ImageSource.gallery);

    imageFile = await tempStore!.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      isFaceDetected = false;

      imageFile = imageFile;
    });
  }

    void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: result));
    ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(content: Text('Text copied to clipboard')),
    );
  }

Future readTextfromanImage() async {
  result = '';
  final inputImage = InputImage.fromFile(pickedImage);
  final textDetector = GoogleMlKit.vision.textRecognizer();
  final RecognizedText recognizedText = await textDetector.processImage(inputImage);

  for (TextBlock block in recognizedText.blocks) {
    for (TextLine line in block.lines) {
      for (TextElement element in line.elements) {
        setState(() {
          result += ' ${element.text}';
        });
      }
    }
  }
  log(result);
}


 Future decodeBarCode() async {
    try {
      result = '';
      final inputImage = InputImage.fromFile(pickedImage);
      final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
      final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

      for (Barcode barcode in barcodes) {
        setState(() {
          result = barcode.displayValue ?? '';
        });
      }
      log(result);
    } catch (e) {
      log('Error scanning barcode: $e');
    }
  }
  
  Future labelsread() async {
    result = '';
    final inputImage = InputImage.fromFile(pickedImage);
    final imageLabeler = GoogleMlKit.vision.imageLabeler();
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    for (ImageLabel label in labels) {
      final String text = label.label;
      final double confidence = label.confidence;
      setState(() {
        result += ' $text     $confidence\n';
      });
    }
    log(result);
  }

  Future detectFace() async {
    result = '';
    final inputImage = InputImage.fromFile(pickedImage);
    final faceDetector = GoogleMlKit.vision.faceDetector();
    final List<Face> faces = await faceDetector.processImage(inputImage);
    rect = [];
    for (Face face in faces) {
      rect.add(face.boundingBox);
    }
    setState(() {
      isFaceDetected = true;
    });
  }

  void detectMLFeature(String selectedFeature) {
    switch (selectedFeature) {
      case 'Text Scanner':
        readTextfromanImage();
        break;
      case 'Barcode Scanner':
        decodeBarCode();
        break;
      case 'Label Scanner':
        labelsread();
        break;
      case 'Face Detection':
        detectFace();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedItem = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            copyToClipboard();
          },
          child: Container(
            width: 300,
            height: 60,
            color: Colors.cyan,
            child:const Center(child: Text("Copy Text ",
            style: TextStyle(
              color: Colors.white
            ),)),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(selectedItem),
        actions: [
          ElevatedButton(
            
            onPressed: getImageFromGallery,
            child:const Icon(
              Icons.add_a_photo,
              color: Colors.cyan,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          isImageLoaded && !isFaceDetected
              ? Center(
                  child: Container(
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(pickedImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : isImageLoaded && isFaceDetected
                  ? Center(
                      child: Container(
                        child: FittedBox(
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: CustomPaint(
                              painter: FacePainter(rect: rect, imageFile: imageFile),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(result),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          detectMLFeature(selectedItem);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var imageFile;

  FacePainter({required this.rect, required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    for (Rect rectangle in rect) {
      canvas.drawRect(
        rectangle,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
