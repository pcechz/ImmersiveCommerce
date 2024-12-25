import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/presentation/utils/colors.dart';
import 'package:immersive_commerce/presentation/utils/widget.dart';
import 'package:immersive_commerce/presentation/viewmodels/auth_viewmodel.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileScreen extends  ConsumerWidget {

  var emailCont = TextEditingController();
  var fullNameCont = TextEditingController();
  String? selectedValue = "Male";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    emailCont.text = authState.user?.email ?? "";
    fullNameCont.text = authState.user?.name ?? "";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopBar("Profile"),


            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 100,
                        ),
                      ).paddingAll(4),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 30, right: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.cardColor,
                      border: Border.all(color: colorPrimary, width: 1),
                    ),
                    child: Icon(Icons.camera_alt, color: colorPrimary, size: 16),
                  )
                ],
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              controller: fullNameCont,
              textCapitalization: TextCapitalization.words,
              style: primaryTextStyle(),
              decoration: InputDecoration(
                filled: false,
                hintText: "FullName",
                hintStyle: primaryTextStyle(),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0),
                ),
              ),
            ).paddingAll(16),
            16.height,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: emailCont,
              textCapitalization: TextCapitalization.words,
              style: primaryTextStyle(),
              decoration: InputDecoration(
                filled: false,
                hintText: "Email",
                hintStyle: primaryTextStyle(),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0),
                ),
              ),
            ).paddingAll(16),
            28.height,
            SizedBox(
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                padding: EdgeInsets.all(16),
                child: text("Save profile", fontSize: 14, textColor: Colors.white),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                color: colorPrimary,
                onPressed: () => {},
              ),
            ).paddingAll(16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                padding: EdgeInsets.all(16),
                child: text(
                  "Log Out",
                  fontSize: 14,
                  textColor: colorPrimary,
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40.0),
                  side: BorderSide(color: colorPrimary, width: 1),
                ),
                color: context.cardColor,
                onPressed: ()  {
                ref.read(authProvider.notifier).logout(context);
                },
              ),
            ).paddingAll(16)
          ],
        ),
      ),
    );
  }
}