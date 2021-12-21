import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';

class YourRoom extends StatefulWidget {
  static const String routeName = "/yourRoom";

  @override
  _YourRoom createState() => _YourRoom();
}

class _YourRoom extends State<YourRoom> {
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
        title: Text("Your Room ID", style: GoogleFonts.workSans(
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
            top: 20, bottom: 20,
        ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Unique Code", style: GoogleFonts.workSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w300
                  ),),
                  IconButton(onPressed: (){},
                      color: Colors.amber,
                      icon: Icon(FeatherIcons.copy))
                ],
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Container(
                    height:90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: DarkPalette.darkYellow)

                    ),
                    child: Center(
                      child: Text("Q", style: GoogleFonts.workSans(
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber
                      ))
                    ),
                  ),
                Container(
                  height:90,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: DarkPalette.darkYellow)

                  ),
                  child:  Center(
                      child: Text("Y", style: GoogleFonts.workSans(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber
                      ))
                  ),
                ),
                Container(

                  height:90,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: DarkPalette.darkYellow)

                  ),
                  child:  Center(
                      child: Text("L", style: GoogleFonts.workSans(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber
                      ))
                  ),
                ),
                Container(
                  height:90,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: DarkPalette.darkYellow)

                  ),
                  child:  Center(
                      child: Text("1", style: GoogleFonts.workSans(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber
                      ))
                  ),
                )
              ],
            ),
            Spacer(),
            Text("QR Code", style: GoogleFonts.workSans(
                fontSize: 18,
                fontWeight: FontWeight.w300
            ),),
            AspectRatio(aspectRatio: 1/1,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/qr_bounding_box.png"
                        ),
                        fit: BoxFit.contain
                    )
                ),
              child: Center(
                child: QrImage(
                  data: 'TQYL1',
                  version: QrVersions.auto,
                  size: 200,
                  gapless: false,
                  backgroundColor: Colors.white,
                ),
              ),
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    gradient: DarkPalette.borderGradient1,
                    border: Border.all(
                      color: DarkPalette.darkYellow,
                      width: 3
                    )

                  ),
                  child: Center(
                    child: Icon(
                        FeatherIcons.share2,
                        size: 30,
                        color: DarkPalette.darkYellow
                    )
                  ),
                )
              ],
            )


          ],
        ),
      ),
    );
  }
}
