import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoominghome/sidedrawer.dart';

import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late BuildContext ctx;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
      key: scaffoldState,
      drawer: navBar(ctx,scaffoldState),

      // resizeToAvoidBottomInset: false,
      backgroundColor: Clr().white,
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/pattern.png'),fit: BoxFit.fitWidth,alignment: Alignment.topCenter)
          ),
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
                        onTap: (){
                          STM().back2Previous(ctx);
                        },
                        child: SvgPicture.asset('assets/backbtn.svg',height: 20,width: 20,))),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Notifications',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ) ,
                SizedBox(
                  height: Dim().d80,
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics:  BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 8, right: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lorem Ipsum is simply dummy text ',
                              style: Sty().largeText.copyWith(
                                  color: Clr().primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At amet, id lorem placerat neque morbi. Gravida integer lectus tristique ',
                              style: TextStyle(
                                height: 1.5,
                                color: Color(0xff747688),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Today, 11:44 am',
                                  style: TextStyle(
                                    color: Color(0xff28282A),
                                    fontSize: 12,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),







              ],
            ),
          ),
        ),
      ),
    );
  }
}
