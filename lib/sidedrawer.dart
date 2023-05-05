
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/aboutus.dart';
import 'package:zoominghome/contactus.dart';
import 'package:zoominghome/signin.dart';

import 'help.dart';
import 'manage/static_method.dart';
import 'myleads.dart';
import 'myprofile.dart';
import 'mywallet.dart';
import 'notifications.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

Widget navBar(context,key){
  return SafeArea(
    child: WillPopScope(
      onWillPop: () async {
        if (key.currentState.isDrawerOpen) {
          key.currentState.openEndDrawer();
        }
        return true;
      },
      child: Drawer(
        width: 270,
        backgroundColor: Clr().secondaryColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: Dim().d8),
          child: Column(
            children: [
              SizedBox(
                height: Dim().d44,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/splogo.png',width: 220,
                  height: Dim().d80,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: Dim().d24,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/profile.svg',width: 16,height: 18,
                ),
                minLeadingWidth : 10,

                title: Text(
                  'My Profile',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  STM().redirect2page(context, MyProfile());
                  close(key);
                },
              ),
              SizedBox(
                height: 0,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/mywallet.svg',width: 16,height: 18,),
                title: Text(
                  'My Wallet',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  STM().redirect2page(context, MyWallet());
                  close(key);
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/myleads.svg',width: 23,height: 21,),
                title: Text(
                  'My Leads',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  STM().redirect2page(context, MyLeads());
                  close(key);
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/helpicon.svg',width: 16,height: 18,),
                title: Text(
                  'Help',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  STM().redirect2page(context, Help());
                  // STM().openWeb('https://arhamparivar.org/privacy_policy');
                  close(key);
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/notification.svg',width: 16,height: 18,),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  STM().redirect2page(context, NotificationPage());
                  // STM().openWeb('https://arhamparivar.org/terms_conditions');
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/Privacy Policy.svg',width: 16,height: 18,),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  STM().openWeb('https://sonibro.com/zooming_home/privacy');
                  close(key);
                },
              ),
              SizedBox(
                height: Dim().d4,
              ),
              ListTile(
                leading: SizedBox(
                    width: 18,
                    height: 22,
                    child: SvgPicture.asset('assets/privacypolicyicon.svg',width: 22,height: 22,)),
                title: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  // STM().redirect2page(context, CouponCode());
                  STM().openWeb('https://sonibro.com/zooming_home/terms');
                  close(key);
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/refund.svg',width: 16,height: 18,),
                title: Text(
                  'Refund Policy',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  // STM().redirect2page(context, Contact());
                  STM().openWeb('https://sonibro.com/zooming_home/refund_policy');
                  close(key);
                },
              ),
              SizedBox(
                height: Dim().d4,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/aboutus.svg',width: 16,height: 18,),
                title: Text(
                  'About Us',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  STM().redirect2page(context, aboutus());
                  close(key);
                },
              ),
              SizedBox(
                height: 4,
              ),
              ListTile(
                leading: SvgPicture.asset('assets/contactus.svg',width: 16,height: 18,),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                      color: Clr().primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                minLeadingWidth : 10,
                onTap: () {
                  STM().redirect2page(context, contactus());
                  close(key);
                },
              ),
              SizedBox(
                height:40,
              ),

              Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () async{
                      SharedPreferences sp = await SharedPreferences.getInstance();
                      sp.clear();
                      STM().finishAffinity(context, SingIn());
                    },
                    child: SizedBox(
                      height: Dim().d48,
                      width: Dim().d160,
                      child: Card(
                        elevation: 0,
                        color: Clr().secondaryColor,
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
                  ),
                ),
              ),
              SizedBox(
                height:30,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
void close(key) {
  key.currentState.openEndDrawer();
}