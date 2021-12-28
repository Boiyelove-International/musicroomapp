import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';

import 'events.dart';

class SearchResultScreen extends StatefulWidget {
  SearchResultScreen({Key? key, this.title = "Search Results",  this.url,
  this.actions} ) : super(key: key);

  String? title;
  List<Widget>? actions = [];
  static const String routeName = "/search";
  String? url;

  @override
  _SearchResultScreen createState() => _SearchResultScreen();
}

class _SearchResultScreen extends State<SearchResultScreen> {
  UserType _userType = UserType.partyOrganizer;
  ApiBaseHelper _api = ApiBaseHelper();



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
        child: FutureBuilder(
          future: _api.get("${widget.url}"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {
              List dataItems = snapshot.data;
              print("data length is ${dataItems.length}");
              if (dataItems.isEmpty){
                return EmptyContent();
              }
              return ListView.separated(
                  padding: EdgeInsets.only(top: 30, left: 18, right: 18),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                            isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context){
                                return Wrap(
                                  children: [
                                    PopupWidget(
                                        popup: Popup.nowPlayingFilter,
                                        userType: UserType.partyGuest,
                                        height: 0.7,
                                        song: SongModel(
                                            title: dataItems[index]['title'],
                                            artist: dataItems[index]['artist'],
                                            album_art: dataItems[index]['album_art'],
                                          previewUrl: dataItems[index]['preview']
                                        )
                                    )
                                  ],
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
                              CachedNetworkImage(
                                imageUrl: "${dataItems[index]['album_art']}",
                                placeholder: (context, url) => SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.0,
                                    color: Colors.amber,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              title: Text("${dataItems[index]['title']}", style:GoogleFonts.workSans(
                                fontWeight: FontWeight.bold
                              )),
                              subtitle: Text("${dataItems[index]['artist']}y"),
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
                  itemCount: dataItems.length);
            } else if (snapshot.hasError) {
             return Center(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Icon(IconlyBold.danger),
                   Text("Oops! something went wrong")
                 ],
               ),
             );
            }
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                  strokeWidth: 2,
                )
            );
          },
        )
      ),
    );
  }
}
