import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

/*
class PDF extends StatefulWidget {
  final String link;
  final String name;
  const PDF(this.link, this.name);
  @override
  _PDFState createState() => _PDFState();
}

class _PDFState extends State<PDF> {
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new MaterialApp(
          routes: {
            "/": (_) => new WebviewScaffold(
                  url: widget.link,
                  appBar: new AppBar(
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    centerTitle: true,
                    backgroundColor: Color(0xff03174C),
                    title: new Text(widget.name),
                  ),
                  initialChild: Container(
                    color: Colors.white54,
                    child: const Center(
                      child: Text('Waiting.....'),
                    ),
                  ),
                )
          },
        ));
  }
}

*/

class PDFViewerCachedFromUrl extends StatelessWidget {
  PDFViewerCachedFromUrl({required Key key, required this.url, required this.name}) : super(key: key);
  FirebaseStorage storage = FirebaseStorage.instance;
  final String url;
  final String name;
  // final document;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.name),
        ),
        /*  body: const PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
      ).cachedFromUrl(
         'http://www.africau.edu/images/default/sample.pdf',
        placeholder: (double progress) => Center(child: Text("Loading.."+'$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ));*/
        body: FutureBuilder<PDFDocument>(
            future: getPdfDocument(url),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return PDFViewer(document: snapshot.data as PDFDocument);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Future<PDFDocument> getPdfDocument(url) async {
    var downloadUrl = await this.storage.ref(url).getDownloadURL();
    return await PDFDocument.fromURL(downloadUrl);
  }
}
