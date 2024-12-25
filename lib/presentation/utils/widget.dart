// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/presentation/utils/colors.dart';
import 'package:immersive_commerce/presentation/viewmodels/auth_viewmodel.dart';
import 'package:immersive_commerce/presentation/viewmodels/product_viewmodel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class EditText extends StatefulWidget {
  bool isPassword;
  bool isSecure;
  double fontSize;
  Color textColor;
  String fontFamily;
  String text;
  int maxLine;
  TextEditingController? mController;

  VoidCallback? onPressed;

  EditText({
    this.fontSize = 16,
    this.textColor = textColorSecondary,
    this.fontFamily = "Regular",
    this.isPassword = true,
    this.isSecure = false,
    this.text = "",
    this.mController,
    this.maxLine = 1,
  });

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextFormField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: colorPrimary,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 4, 8),
          hintText: widget.text,
          labelText: widget.text,
          hintStyle: secondaryTextStyle(),
          labelStyle: secondaryTextStyle(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColorPrimary, width: 0.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColorPrimary, width: 0.0),
          ),
        ),
        maxLines: widget.maxLine,
        style: TextStyle(fontSize: widget.fontSize, color: textColorPrimary, fontFamily: widget.fontFamily),
      );
    } else {
      return TextField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: colorPrimary,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            child: Icon(widget.isPassword ? Icons.visibility : Icons.visibility_off, color: Colors.black),
          ),
          contentPadding: EdgeInsets.fromLTRB(16, 8, 4, 8),
          hintText: widget.text,
          labelText: widget.text,
          hintStyle: secondaryTextStyle(),
          labelStyle: secondaryTextStyle(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColorPrimary, width: 0.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColorPrimary, width: 0.0),
          ),
        ),
        style: TextStyle(fontSize: widget.fontSize, color: textColorPrimary, fontFamily: widget.fontFamily),
      );
    }
  }
}

// ignore: must_be_immutable
class AppButtons extends StatefulWidget {
  String textContent;
  VoidCallback onPressed;

  AppButtons({required this.textContent, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return AppButtonsState();
  }
}

class AppButtonsState extends State<AppButtons> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: Colors.white),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: widget.onPressed,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[gradient1, gradient2]),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Text(
              widget.textContent,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TopBar extends ConsumerWidget {
  final String titleName;
  final bool? isHomePage;

  TopBar(this.titleName, {this.isHomePage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final products = ref.watch(productProvider).when(
      data: (data) => data,
      loading: () => [],
      error: (e, _) => [],
    );

    final favoriteCount = products.where((product) => product.isFavorite).length;


    return SafeArea(
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        //color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          isHomePage == true ? SizedBox() :  IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: text(
                titleName,
                textColor: textColorPrimary,
                fontSize: 20,
              ),
            ),
            authState.user != null
                ? Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      '/favourites',
                    );
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Icon(
                        favoriteCount > 0 ?   Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 28,
                      ),
                      if (favoriteCount > 0)
                        Positioned(
                          right: 0,
                          top: -4,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.black,
                            child: Text(
                              '$favoriteCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      '/profile',
                    );
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

Widget text(
    String? text, {
      double fontSize = 16,
      Color? textColor,
      String? fontFamily,
      bool isCentered = false,
      int maxLine = 1,
      double latterSpacing = 0.5,
      bool textAllCaps = false,
      bool isLongText = false,
      bool lineThrough = false,
    }) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: textColor ?? textSecondaryColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}



class ShimmerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 6, // Placeholder count
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
      ),
    );
  }
}
