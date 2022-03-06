import 'dart:io';
import 'dart:ui';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../utils/models.dart';

class YourRoom extends StatelessWidget {
  static const String routeName = "/yourRoom";
  Event event;
  YourRoom({required this.event});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          color: DarkPalette.darkGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text("Your Room ID",
            style: GoogleFonts.workSans(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Unique Code",
                      style: GoogleFonts.workSans(
                          fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(
                                  new ClipboardData(text: "${event.code!}"))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "Copied to clipboard",
                              textAlign: TextAlign.center,
                            )));
                          });
                        },
                        color: Colors.amber,
                        icon: Icon(FeatherIcons.copy))
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: event.code!
                  .split("")
                  .map((e) => Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: DarkPalette.darkYellow)),
                        child: Center(
                            child: Text(e,
                                style: GoogleFonts.workSans(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber))),
                      ))
                  .toList(),
            ),
            Spacer(),
            Text(
              "QR Code",
              style: GoogleFonts.workSans(
                  fontSize: 18, fontWeight: FontWeight.w300),
            ),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/qr_bounding_box.png"),
                            fit: BoxFit.contain)),
                    child: Center(
                      child: QrImage(
                        data: '${event.code!}',
                        version: QrVersions.auto,
                        size: 290,
                        gapless: false,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: DarkPalette.borderGradient1,
                      border:
                          Border.all(color: DarkPalette.darkYellow, width: 3)),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      shareImage();
                    },
                    child: Icon(FeatherIcons.share2,
                        size: 30, color: DarkPalette.darkYellow),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  shareImage() async {
    final qrValidationResult = QrValidator.validate(
      data: "${event.code}",
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (!qrValidationResult.isValid) return;

    final painter = QrPainter.withQr(
      qr: qrValidationResult.qrCode!,
      color: const Color(0xFFffffff),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';

    final picData =
        await painter.toImageData(2048, format: ImageByteFormat.png);
    await writeToFile(picData!, path);

    await Share.shareFiles([path],
        mimeTypes: ["image/png"],
        subject: 'Join ${event.name!} by:${event.organizer}',
        text: """About Event:
${event.about!} \n
To join this event,
Use unique code: ${event.code!}
or link: example.com/${event.code}""");
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
