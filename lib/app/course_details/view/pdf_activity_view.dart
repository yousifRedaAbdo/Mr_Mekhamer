import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:mohamed_mekhemar/app/course_content/view_model/course_content_view_model.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/texts.dart';

class PdfActivityView extends StatelessWidget {
  String courseId;
  PdfActivityView({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseContentViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        await viewModel.getPdfUrl(
          courseId: courseId,
          token: viewModel.token,
        );
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: viewModel.pdfLinksListAfter.isEmpty
                ? Center(
                    child: mediumText('no_data'.tr()),
                  )
                : ListView.builder(
                    itemCount: viewModel.pdfLinksListAfter.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: mainColor,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/icons_pdf.png',
                              height: 35,
                            ),
                            widthSpace(20),
                            Flexible(
                              child: mediumText(
                                viewModel.pdfNameList[index],
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ).onTap(
                        () async {
                          await viewModel.apiServices.incPdfView(
                            pdfId: viewModel.pdfList[index].instance!,
                            token: viewModel.token,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayPdf(
                                viewModel.pdfLinksListAfter[index],
                                viewModel.pdfNameList[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

class DisplayPdf extends StatefulWidget {
  @override
  _DisplayPdfState createState() => _DisplayPdfState();
  String pdfLink;
  String pdfName;

  DisplayPdf(this.pdfLink, this.pdfName, {Key? key}) : super(key: key);
}

class _DisplayPdfState extends State<DisplayPdf> {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'pdf';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  void initState() {
    getFileFromUrl(widget.pdfLink).then(
      (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          centerTitle: true,
          title: appBarTitle(widget.pdfName),
        ),
        body: PDFView(
          filePath: urlPDFPath,
          autoSpacing: true,
          enableSwipe: true,
          pageSnap: true,
          swipeHorizontal: true,
          nightMode: false,
          onRender: (pages) {
            setState(() {
              _totalPages = pages!;
              pdfReady = true;
            });
          },
          onViewCreated: (PDFViewController vc) {
            setState(() {
              _pdfViewController = vc;
            });
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.chevron_left),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(
                  () {
                    if (_currentPage < _totalPages - 1) {
                      _currentPage++;
                      _pdfViewController.setPage(_currentPage);
                    }
                  },
                );
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mainColor,
            centerTitle: true,
            title: appBarTitle(
              "Loading",
            ),
          ),
          body: const Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          ),
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mainColor,
            centerTitle: true,
            title: appBarTitle(
              "PDF Not Available",
            ),
          ),
          body: const Center(
            child: Text(
              "PDF Not Available",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }
  }
}
