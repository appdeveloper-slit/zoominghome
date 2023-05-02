import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoominghome/manage/static_method.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: bottomBarLayout(ctx, 2),



      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading:Padding(
          padding: EdgeInsets.all(Dim().d16),
          child: InkWell(
              onTap: (){
                STM().back2Previous(ctx);
              },
              child: SvgPicture.asset('assets/backbtn.svg')),
        ),

      ),
      key: scaffoldState,
      drawer: navBar(ctx,scaffoldState),

      // resizeToAvoidBottomInset: false,
      backgroundColor: Clr().white,
      body: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/pattern.png'),fit: BoxFit.fitWidth,alignment: Alignment.topCenter)
        ),
        child: Padding(
          padding: EdgeInsets.all(Dim().d16),
          child: Column(
            children: [
              SizedBox(
                height: Dim().d60,
              ),
              Align(
                 alignment: Alignment.center,
                child: Text(
                  'My Profile',
                  style: Sty().largeText.copyWith(
                      color: Clr().primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ) ,
              SizedBox(
                height: Dim().d100,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: Dim().d8,right: Dim().d8,top: Dim().d16,bottom: Dim().d16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Category:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Interior Designing',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Name:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Darshan Jadhav',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Mobile No.:-",
                              style: Sty().smallText.copyWith(
                                fontSize: 14,
                                color: Clr().primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' 82893272024',
                                  style: Sty().mediumText.copyWith(
                                      color: Clr().textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),

                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/editbtn.svg'),
                        ],
                      ),
                      SizedBox(height: Dim().d16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Email Address:-",
                              style: Sty().smallText.copyWith(
                                fontSize: 14,
                                color: Clr().primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Dj@gmail.com',
                                  style: Sty().mediumText.copyWith(
                                      color: Clr().textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),

                              ],
                            ),
                          ),
                          // SvgPicture.asset('assets/editbtn.svg'),
                        ],
                      ),
                      SizedBox(height: Dim().d36),
                      Align(
                        alignment: Alignment.center,
                        child:  SizedBox(
                          height: Dim().d40,
                          width: Dim().d180,
                          child: ElevatedButton(
                              onPressed: () {

                                // plansDialog(ctx);
                                // STM().redirect2page(ctx, CouponCode());
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.5,
                                  backgroundColor: Clr().primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35))),
                              child: Text(
                                'Update',
                                style: Sty().mediumText.copyWith(
                                    fontSize: 16,
                                    color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                              )),
                        ),
                        // child: SizedBox(
                        //   height: Dim().d44,
                        //   width: Dim().d146,
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         // STM().redirect2page(ctx, OTPVerification());
                        //       },
                        //       style: ElevatedButton.styleFrom(
                        //           elevation: 0.5,
                        //           backgroundColor: Clr().primaryColor,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(35))),
                        //       child: Text(
                        //         'Update',
                        //         style: Sty().mediumText.copyWith(
                        //             fontSize: 16,
                        //             color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                        //       )),
                        // ),
                      ),




                    ],
                  ),
                ),
              ),



              Column(
                children: [
                  SizedBox(
                    height: Dim().d16,
                  ),
                  SizedBox(
                    height: Dim().d48,
                    width: Dim().d220,
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),side: BorderSide(width: 1, color:Clr().primaryColor)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/logout.svg'),
                            SizedBox(width: Dim().d8,),
                            Text(
                              'Log Out',
                              style: Sty().largeText.copyWith(
                                  color: Clr().primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dim().d8,
                  ),
                  Column(
                    children: [

                      Text(
                        'Delete My Account',
                        style: Sty().smallText.copyWith(
                            height: 1.5,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Clr().primaryColor),
                      ),
                      SizedBox(
                        height: Dim().d4,
                      ),
                      Text(
                        '____________',
                        style: Sty().smallText.copyWith(
                            height: -0.1,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Clr().primaryColor),
                      ),
                      SizedBox(
                        height: Dim().d28,
                      ),
                    ],
                  ),
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
