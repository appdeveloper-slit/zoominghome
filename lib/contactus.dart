import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class contactus extends StatefulWidget {
  const contactus({super.key});

  @override
  State<contactus> createState() => _contactusState();
}

class _contactusState extends State<contactus> {
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
                    'Contact Us',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: Dim().d160,
                ),
                InkWell(onTap: ()async{
                  await launch('mailto:infozoominghome@gmail.com');
                },
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/mail.svg'),
                      SizedBox(height: Dim().d8),
                      Text('infozoominghome@gmail.com',
                        style: Sty().mediumText.copyWith(
                            fontWeight: FontWeight.w500
                        ),),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: Dim().d20),
                InkWell(
                  onTap: ()async{
                    await launch("whatsapp://send?phone=9321033767");
                  },
                  child: Column(
                    children: [
                      const Icon(Icons.call),
                      SizedBox(height: Dim().d8),
                      Text(
                        '+91 9321033767',
                          style: Sty().mediumText.copyWith(
                              fontWeight: FontWeight.w500
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
