import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class LongButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final Function onpressed;

  LongButtonWidget({
    required this.buttonText,
    required this.width,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              Colors.deepPurple.shade400,
              Colors.deepPurple.shade200,
            ],
          ),
          // color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            onpressed();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MRSkeletonLoader extends StatelessWidget {
  double width;
  double height;

  MRSkeletonLoader({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SkeletonLoader(
        builder: Container(
          width: width,
          height: height,
          color: Colors.grey.withOpacity(0.1),
        )
    );
  }
}