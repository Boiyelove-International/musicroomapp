import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  Function? onCompleted;

  QRScannerScreen({Key? key, this.onCompleted}) : super(key: key);

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  bool isJoining = false;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          "Scan the QR Code",
          style: GoogleFonts.workSans(
              fontWeight: FontWeight.w700, fontSize: 20, height: 2),
          textAlign: TextAlign.center,
        ),
        // SizedBox(height: 20),
        // Text("Place your phone camera over the QR Code provides and scan it", style: GoogleFonts.workSans(
        //     fontWeight: FontWeight.w300,
        //     fontSize: 16,
        //     height:1.8
        // ), textAlign: TextAlign.center,),
        Padding(
            padding: EdgeInsets.all(20),
            child: Center(
                child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/qr_bounding_box.png"),
                        fit: BoxFit.contain)),
                child: Center(
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
              ),
            ))),
        Visibility(
          visible: isJoining,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(
              color: Colors.amber,
              strokeWidth: 1,
            ),
          ),
        )
      ]),
    );
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    ApiBaseHelper _api = ApiBaseHelper();
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        isJoining = true;
      });
      log("get event join with code");
      _api.get("/event/join/?q=${result?.code}").then((value) {
        setState(() {
          isJoining = false;
        });
        if (widget.onCompleted != null) {
          widget.onCompleted!(value);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
