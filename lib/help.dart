import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: bottomBarLayout(ctx, 3),



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
                //    alignment: Alignment.center,
                //   child: Text(
                //     'Help',
                //     style: Sty().largeText.copyWith(
                //         color: Clr().primaryColor,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 24),
                //   ),
                // ) ,
                // SizedBox(
                //   height: Dim().d110,
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
                    'Help',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ) ,
                SizedBox(
                  height: Dim().d120,
                ),



                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Frequently Asked Questions',
                    style: Sty().largeText.copyWith(
                        color: Clr().primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),

                ),
                SizedBox(
                  height: Dim().d2,
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: Dim().d12),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    bool _isExpanded = false;
                    return StatefulBuilder(
                        builder: (context,setState) {
                          return Padding(
                            padding:  EdgeInsets.symmetric(vertical: 10),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: Container(
                                decoration: BoxDecoration(

                                    border: Border.symmetric(horizontal: BorderSide( color: Colors.grey.shade100, width: 1,))),

                                child: ListTileTheme(
                                  minLeadingWidth: 0,


                                  child: ExpansionTile(


                                    backgroundColor: Clr().white ,
                                    collapsedBackgroundColor: Colors.white,
                                    title: Text('Lorem ipsum dolor sit amet consectetur. Accumsan porttitor fermentum gravida ?',style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                    // leading: Icon(Icons.local_pizza),
                                    trailing: _isExpanded ? Icon(Icons.keyboard_arrow_up,size: 30,color: Clr().primaryColor):Icon(Icons.keyboard_arrow_down_rounded,size: 30 ,color: Clr().primaryColor),
                                    onExpansionChanged:(value) {
                                      setState(() {
                                        _isExpanded = value;
                                      });

                                    },
                                    children: <Widget>[
                                      // Divider(
                                      //   color: Colors.grey,
                                      // ),
                                      ListView.builder(
                                        padding: EdgeInsets.symmetric(vertical: Dim().d16),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 1,
                                        itemBuilder: (context, index2) {
                                          // var v = KalyanaksList[index]['kalyanaks'][index2];

                                          return  Column(
                                            children: <Widget>[
                                              // KalyanaksList == null ? Container():
                                              Column(
                                                children: [

                                                  Padding(
                                                    padding: EdgeInsets.only(left: Dim().d16),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child:  Text('Lorem ipsum dolor sit amet consectetur. Accumsan porttitor fermentum gravida Lorem ipsum dolor sit amet consectetur.',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Clr().textColor),),
                                                  ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only( right: Dim().d16),
                                                  //   child: Align(
                                                  //       alignment: Alignment.centerRight,
                                                  //       child: Text('${v['title2'].toString()}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),)),
                                                  // ),
                                                  // Padding(
                                                  //   padding: EdgeInsets.only(left: Dim().d16),
                                                  //   child: Align(
                                                  //       alignment: Alignment.centerLeft,
                                                  //       child: Text('${v['title3'].toString()}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),)),
                                                  // ),
                                                  )
                                                ],
                                              ),


                                            ],
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