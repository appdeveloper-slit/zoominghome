import 'package:flutter/material.dart';
import 'package:zoominghome/home.dart';
import '../help.dart';
import '../manage/static_method.dart';
import '../myleads.dart';
import '../myprofile.dart';
import '../values/colors.dart';

Widget bottomBarLayout(ctx, index) {
  return BottomNavigationBar(
    elevation: 10,
    backgroundColor: Clr().white,
    selectedItemColor: Clr().secondaryColor,
    unselectedItemColor: Clr().black,
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    onTap: (i) async {
      switch (i) {
        case 0:
          STM().finishAffinity(ctx, HomePage());
          break;
        case 1:
          index == 1
              ? STM().replacePage(ctx, MyLeads())
              : STM().redirect2page(ctx, MyLeads());
          break;
        case 2:
          index == 2
              ? STM().replacePage(ctx, MyProfile())
              : STM().redirect2page(ctx, MyProfile());
          break;
        case 3:
          index == 3
              ? STM().replacePage(ctx, Help())
              : STM().redirect2page(ctx, Help());
          break;
      }
    },
    items: STM().getBottomList(index),
  );
}
