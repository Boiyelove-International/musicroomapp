import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/models.dart';

class SearchResultScreen extends StatefulWidget {
  SearchResultScreen({Key? key, this.title = "Search Results",
  this.actions} ) : super(key: key);

  String? title;
  List<Widget>? actions = [];
  static const String routeName = "/search";
  @override
  _SearchResultScreen createState() => _SearchResultScreen();
}

class _SearchResultScreen extends State<SearchResultScreen> {
  UserType _userType = UserType.partyOrganizer;
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
        title: Text("${widget.title}",
        style: GoogleFonts.workSans(
          fontSize: 20,
          fontWeight: FontWeight.w700
        ),),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: widget.actions != null ?  widget.actions : [],
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView.separated(
            padding: EdgeInsets.only(top: 30, left: 18, right: 18),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context){
                        return PopupWidget(
                            popup: Popup.nowPlayingFilter,
                            userType: UserType.partyGuest,
                            height: 0.7
                        );
                        });

                  },
                  child:Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: DarkPalette.darkGrey1,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading:
                        Image.asset("assets/images/album_art_${index + 1}.png"),
                    title: Text("Focus"),
                    subtitle: Text("Single - Joe Boy"),
                    trailing: _userType == UserType.partyOrganizer ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: DarkPalette.borderGradient1,
                            shape: BoxShape.circle
                        ),
                        child: Icon(
                          IconlyBold.plus,
                          size: 20,
                          color: Colors.white,
                        )
                    ) : null,

                  )));
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 30);
            },
            itemCount: 5),
      ),
    );
  }
}
