import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles.dart';

class GoldButton extends StatelessWidget {
  Function() onPressed;
  String buttonText;
  bool isLoading;
  GoldButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isLoading);
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
          onPressed: (){
            if(isLoading) return;
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: isLoading
                ? CircularProgressIndicator(
              color: DarkPalette.darkDark,
            )
                : Text(buttonText,
                style: GoogleFonts.workSans(
                    color: DarkPalette.darkDark,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

