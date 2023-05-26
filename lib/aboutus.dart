import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class aboutus extends StatefulWidget {
  const aboutus({super.key});

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  late BuildContext ctx;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  List<dynamic> notificationList = [];

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      // bottomNavigationBar: bottomBarLayout(ctx, 2),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   leading:Padding(
      //     padding: EdgeInsets.all(Dim().d16),
      //     child: InkWell(
      //         onTap: (){
      //           STM().back2Previous(ctx);
      //         },
      //         child: SvgPicture.asset('assets/backbtn.svg')),
      //   ),
      //
      // ),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Clr().white,
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/pattern.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Column(
              children: [
                // SizedBox(
                //   height: Dim().d60,
                // ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'Notifications',
                //     style: Sty().largeText.copyWith(
                //         color: Clr().primaryColor,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 24),
                //   ),
                // ) ,
                // SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: Dim().d36,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                        onTap: () {
                          STM().back2Previous(ctx);
                        },
                        child: SvgPicture.asset(
                          'assets/backbtn.svg',
                          height: 20,
                          width: 20,
                        ))),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'About Us',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: Dim().d160,
                ),
                Text(
                    "Zooming Home is a Professional Home maintenance services Platform. Here we will provide you only home maintenance categories services, which you will like very much. We're dedicated to providing you the best of Home maintenance services, with a focus on dependability and Home maintenance services solutions providers. We're working to turn our passion for Home maintenance services into a booming online website. We hope you enjoy our Home maintenance services as much as we enjoy offering them to you. \n\n\n We will keep updating more important updates on our platform for all of you. Please give your support and trust",
                    style:
                        Sty().mediumText.copyWith(color: Clr().primaryColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
