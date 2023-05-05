import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/home.dart';
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
  List<dynamic> notificationList = [];
  String? Token;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Token = sp.getString('token') ?? '';
      sp.setString('date', DateTime.now().toString());
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getNotification();
        print(Token);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(onWillPop: ()async{
      STM().finishAffinity(ctx, HomePage());
      return false;
    },
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                            STM().finishAffinity(ctx, HomePage());
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
                  notificationList.isEmpty ? SizedBox(
                    height: MediaQuery.of(ctx).size.height / 1.3,
                    child: Center(
                      child: Text('No Notifications',style: Sty().mediumBoldText),
                    ),
                  ) : ListView.builder(
                    shrinkWrap: true,
                    physics:  BouncingScrollPhysics(),
                    itemCount: notificationList.length,
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
                                '${notificationList[index]['title']}',
                                style: Sty().largeText.copyWith(
                                    color: Clr().primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                               Text(
                                '${notificationList[index]['discription']}',
                                style: const TextStyle(
                                  height: 1.5,
                                  color: Color(0xff747688),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                               Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${notificationList[index]['created_on']}',
                                    style: TextStyle(
                                      color: Color(0xff28282A),
                                      fontSize: 12,
                                    ),
                                  )),
                              Divider(),
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
      ),
    );
  }

  // getNotifications
void getNotification() async {
    var result = await STM().getWithoutDialogtoken(ctx, 'notification',Token);
    var success = result['success'];
    if(success){
      setState(() {
        notificationList = result['notifications'];
      });
    }
}

}
