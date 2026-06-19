import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class SignaturePadPage extends StatefulWidget {
  const SignaturePadPage({super.key});

  @override
  State<SignaturePadPage> createState() => _SignaturePadPageState();
}

class _SignaturePadPageState extends State<SignaturePadPage> {
  final controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.grey.shade900,
    exportBackgroundColor: Colors.white,
  );

  Future<void> saveSignature() async {
    if (controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tanda tangan tidak boleh kosong')),
      );

      return;
    }

    final bytes = await controller.toPngBytes();

    if (bytes == null) return;

    final directory = await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    await file.writeAsBytes(bytes);

    if (!mounted) return;

    Navigator.pop(context, file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        leadingWidth: 40,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade900,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),

        title: const Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 18),
            children: [
              TextSpan(text: 'Tanda tangan '),

              TextSpan(
                text: 'pemilik',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red.shade900,
            ),

            onPressed: () => controller.clear(),
            child: Text('Hapus'),
          ),

          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade900,
            ),

            onPressed: () => saveSignature(),
            child: Text('Simpan'),
          ),
        ],
      ),

      body: Center(
        child: Container(
          width: double.infinity,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            // borderRadius: BorderRadius.circular(8),
          ),

          child: Signature(
            controller: controller,
            backgroundColor: Colors.white,
          ),
        ),
      ),

      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        color: Colors.white,

        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            style: TextStyle(color: Colors.grey.shade900),

            children: [
              TextSpan(text: 'Silahkan tanda tangan pada area yang disediakan.'),

              // TextSpan(
              //   text: 'putih',
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
