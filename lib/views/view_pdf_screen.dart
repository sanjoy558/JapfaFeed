
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:japfa_feed_application/utils/CommonWidgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/viewPdfController.dart';
import '../utils/Constants.dart';

class ViewPdfScreen extends StatefulWidget {
  const ViewPdfScreen({super.key});

  @override
  State<ViewPdfScreen> createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {

  final viewPdfController = Get.put(ViewPdfController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: const Text(
            'Pdf',
            style: TextStyle(
                fontFamily: 'Popins',
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        /* drawer: NavagationDrawerWidget(),*/
        body: Container(
          child: Stack(
            children: [
              Obx(() => viewPdfController.filename1.value.isEmpty
                  ? Container()
                  :Center(
                child: PDFView(
                  filePath: viewPdfController.Pfile.path,
                ),
              ) ,

              ),
              _displayProgress()
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayProgress() {
    return Obx(() => viewPdfController.displayLoading.value == true
        ?  Center(child: progressBarCommon())
        : Container());
  }
}
