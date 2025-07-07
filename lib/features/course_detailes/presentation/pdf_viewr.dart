import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class EmbeddedPDFViewer extends StatefulWidget {
  final String pdfUrl;
  final int index;

  const EmbeddedPDFViewer({super.key, required this.pdfUrl , required this.index});

  @override
  State<EmbeddedPDFViewer> createState() => _EmbeddedPDFViewerState();
}

class _EmbeddedPDFViewerState extends State<EmbeddedPDFViewer> {
  String? _localPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/lesson.pdf');
      await file.writeAsBytes(response.bodyBytes);
      setState(() => _localPath = file.path);
    } catch (e) {
      debugPrint("Failed to load PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_localPath == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return PDFView(
      key: UniqueKey(),
      filePath: _localPath!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageSnap: true,
    );
  }
}
