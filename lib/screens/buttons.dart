import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles.dart';

class GoldButton extends StatefulWidget {
  Function onPressed;
  String buttonText;
  GoldButton({Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  _GoldButton createState() => _GoldButton();
}

class _GoldButton extends State<GoldButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: DarkPalette.borderGradient1,
          // color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(50, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () async {
            if (!loading) {
              setState(() {
                loading = true;
              });
              widget.onPressed();
              setState(() {
                loading = false;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: loading
                ? CircularProgressIndicator(
                    color: DarkPalette.darkDark,
                  )
                : Text(widget.buttonText,
                    style: GoogleFonts.workSans(
                        color: DarkPalette.darkDark,
                        fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
