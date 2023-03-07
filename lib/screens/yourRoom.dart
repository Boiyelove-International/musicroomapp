import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/models.dart';

class ShareEventButton extends StatefulWidget {
  ShareEventButton({Key? key, required this.event}) : super(key: key);
  Event event;

  @override
  _ShareEventButtonState createState() => _ShareEventButtonState();
}

class _ShareEventButtonState extends State<ShareEventButton> {
  bool _shareLoading = false;

  shareImage() async {
    setState(() {
      _shareLoading = true;
    });
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://musicalroom.co.uk/${widget.event.code}/"),
      uriPrefix: "https://musicalroom.page.link",
      androidParameters:
          const AndroidParameters(packageName: "uk.co.musicalroom.app"),
      iosParameters:
          const IOSParameters(bundleId: 'uk.co.musicalroom.musicalroom'),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    final qrValidationResult = QrValidator.validate(
      data: "${widget.event.code}",
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
    log(dynamicLink.shortUrl.toString());
    await Share.shareFiles([path],
        mimeTypes: ["image/png"],
        subject: 'Join ${widget.event.name!} by:${widget.event.organizer}',
        text: """About Event:
${widget.event.about!} \n
To join this event,
Use unique code: ${widget.event.code!}
or Scan the QR Code or link this link ${dynamicLink.shortUrl}
""");
    setState(() {
      _shareLoading = false;
    });
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _shareLoading
            ? CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 1,
              )
            : Container(
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
    );
  }
}

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
            ShareEventButton(
              event: event,
            )
          ],
        ),
      ),
    );
  }
}
