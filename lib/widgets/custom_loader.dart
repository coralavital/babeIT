import 'package:babe_it/theme/theme_colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomLoader {
  static CustomLoader? _customLoader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader!;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader!;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState? _overlayState; //= new OverlayState();
  OverlayEntry? _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return SizedBox(height: Dimensions.size30, width: Dimensions.size30, child: buildLoader(context));
      },
    );
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState!.insert(_overlayEntry!);
  }

  hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print("Exception:: $e");
    }
  }

  buildLoader(BuildContext context, {Color? backgroundColor}) {
    backgroundColor ??= const Color(0xffa8a8a8).withOpacity(.5);

    return CustomScreenLoader(
      height: Dimensions.size20,
      width: Dimensions.size20,
      backgroundColor: backgroundColor,
    );
  }
}

class CustomScreenLoader extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  const CustomScreenLoader(
      {Key? key,
      this.backgroundColor = const Color(0xfff8f8f8),
      this.height = 30,
      this.width = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Container(
        height: height,
        width: height,
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(Dimensions.size30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.size15),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox(
                height: Dimensions.size30,
                width: Dimensions.size30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ThemeColors().blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
