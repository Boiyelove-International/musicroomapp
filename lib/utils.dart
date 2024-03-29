import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/utils/models.dart';

class GradientBorder extends Border {
  final Gradient borderGradient;
  final double width;

  const GradientBorder({this.width = 0.0, required this.borderGradient})
      : super();

  @override
  void paint(Canvas canvas, Rect rect,
      {TextDirection? textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius? borderRadius}) {
    if (isUniform) {
      switch (shape) {
        case BoxShape.circle:
          assert(borderRadius == null,
              'A borderRadius can only be given for rectangular boxes.');
          this._paintGradientBorderWithCircle(canvas, rect);
          break;
        case BoxShape.rectangle:
          if (borderRadius != null) {
            this._paintGradientBorderWithRadius(canvas, rect, borderRadius);
            return;
          }
          this._paintGradientBorderWithRectangle(canvas, rect);
          break;
      }
      return;
    }
  }

  void _paintGradientBorderWithRadius(
      Canvas canvas, Rect rect, BorderRadius borderRadius) {
    final Paint paint = Paint();
    final RRect outer = borderRadius.toRRect(rect);

    paint.shader = borderGradient.createShader(outer.outerRect);

    if (width == 0.0) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.0;
      canvas.drawRRect(outer, paint);
    } else {
      final RRect inner = outer.deflate(width);
      canvas.drawDRRect(outer, inner, paint);
    }
  }

  void _paintGradientBorderWithCircle(Canvas canvas, Rect rect) {
    final double radius = (rect.shortestSide - width) / 2.0;
    final Paint paint = Paint();
    paint
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..shader = borderGradient
          .createShader(Rect.fromCircle(center: rect.center, radius: radius));

    canvas.drawCircle(rect.center, radius, paint);
  }

  void _paintGradientBorderWithRectangle(Canvas canvas, Rect rect) {
    final Paint paint = Paint();
    paint
      ..strokeWidth = width
      ..shader = borderGradient.createShader(rect)
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect.deflate(width / 2.0), paint);
  }

  factory GradientBorder.uniform({
    Gradient gradient = const LinearGradient(colors: [Color(0x00000000)]),
    double width = 1.0,
  }) {
    return GradientBorder._fromUniform(gradient, width);
  }

  const GradientBorder._fromUniform(Gradient gradient, double width)
      : assert(width >= 0.0),
        borderGradient = gradient,
        width = width;
}

Future<Map<String, String>> getDeviceData() async {
  late String deviceName;
  late String deviceVersion;
  late String identifier;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.androidId; //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor; //UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

//if (!mounted) return;
  return {
    "deviceName": deviceName,
    "deviceVersion": deviceVersion,
    "deviceId": identifier,
    "deviceOS": Platform.operatingSystem
  };
}

Future<String> getDeviceId() async {
  String deviceName;
  String deviceVersion;
  late String identifier;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.androidId; //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor; //UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

//if (!mounted) return;
  return identifier;
}

List<Widget> MRbuildAttendeeIcons(Event event,
    {String alignment = 'left', double? radius}) {
  List<Widget> icons = [];
  double count = 0;

  List temp = event.attendees;
  if (temp.length >= 2) {
    temp = temp.sublist(0, 3);
  }
  temp.forEach((e) {
    Widget avatar = CircleAvatar(
      backgroundImage: NetworkImage(e['profile_photo'] ?? ''),
      radius: radius ?? 19,
    );
    if (alignment == 'right') {
      icons.add(Positioned(right: count, child: avatar));
    } else {
      icons.add(Positioned(left: count, child: avatar));
    }

    count += 15;
  });
  return icons;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

MRselectSong(Map dataItem, BuildContext context, Event? event,
    {bool pushReplacement = false}) {
  if (event == null) {
    return;
  }
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            PopupWidget(
                popup: Popup.nowPlayingFilter,
                userType: UserType.partyGuest,
                height: 0.8,
                event: event,
                song: SongModel(
                    title: dataItem['song_title'],
                    artist: dataItem['artist_name'],
                    album_art: dataItem['album_art'],
                    previewUrl: dataItem['song_url'],
                    apple_song_id: dataItem['apple_song_id'],
                    apple_music_link: dataItem['apple_music_link']))
          ],
        );
      });
}

MRselectSong2(Map dataItem, BuildContext context,
    {bool slideToEvenGrid = false}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            )),
        padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        height: MediaQuery.of(context).size.height * 0.9,
        child: SuggestEventForm(
          userType: UserType.partyGuest,
          slideToEvenGrid: slideToEvenGrid,
          song: SongModel(
              title: dataItem['song_title'],
              artist: dataItem['artist_name'],
              album_art: dataItem['album_art'],
              previewUrl: dataItem['song_url'],
              apple_song_id: dataItem['apple_song_id'],
              apple_music_link: dataItem['apple_music_link']),
        )),
  );
}
