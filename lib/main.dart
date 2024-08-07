import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'qr_view_example.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String qrText = ""; // Initial QR text input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator and Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text field to enter data for QR code generation as sometimes there can be mistakes we are not auto clearing but button can be added to clear
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // (IMPORTANT) QR codes can hold up to 7,089 characters of numeric data, 4,296 characters of alphanumeric data, or 2,953 bytes (8-bit binary data) at the highest error correction level (Level H).
                onChanged: (newText) {
                  setState(() {
                    qrText = newText;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text for QR code',
                ),
              ),
            ),
            // Button to generate QR code based on entered text
            ElevatedButton(
              onPressed: () {
                if (qrText.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenerateQRScreen(qrText: qrText),
                      // In main.dart itself
                    ),
                  );
                }
              },
              child: Text('Generate QR Code'),
            ),
            SizedBox(height: 20),
            // Button to navigate to QR code scanning screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRViewExample()),
                );
              },
              child: Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateQRScreen extends StatelessWidget {
  final String qrText;

  const GenerateQRScreen({Key? key, required this.qrText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate QR Code')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: qrText,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
