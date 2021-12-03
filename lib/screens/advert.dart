import 'package:flutter/material.dart';
import 'package:musicroom/styles.dart';

class Advert extends StatefulWidget {
  @override
  _Advert createState() => _Advert();
}

class _Advert extends State<Advert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: true,
      bottom: true,
      child: Container(
        height: MediaQuery.of(context).size.height * 1.0,
        color: Colors.white,
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 7.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/advert_bg"),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      color: DarkPalette.darkGold,
                      onPressed: null,
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                      iconSize: 40,
                    ),
                  ))
                ],
              )),
          Text("Enjoy Premium SSound"),
          Text(
              "Advertisement popup window could be videos, pictures and the likes predetermined by admob."),
          Row(
            children: [
              Expanded(
                child:
                    ElevatedButton(onPressed: null, child: Text("Get Started")),
              )
            ],
          )
        ]),
      ),
    ));
  }
}
