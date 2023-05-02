import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:zoominghome/manage/static_method.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'buylead.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class LeadDetails extends StatefulWidget {
  final dynamic leaddeatils;
  const LeadDetails({super.key,this.leaddeatils});

  @override
  State<LeadDetails> createState() => _LeadDetailsState();
}

class _LeadDetailsState extends State<LeadDetails> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  var v;
  @override
  void initState() {
    // TODO: implement initState
    v = widget.leaddeatils;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: ()async{
        STM().back2Previous(ctx);
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                  //     'Lead Details',
                  //     style: Sty().largeText.copyWith(
                  //         color: Clr().primaryColor,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 24),
                  //   ),
                  // ) ,
                  // SizedBox(
                  //   height: Dim().d100,
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
                      'Lead Details',
                      style: Sty().largeText.copyWith(
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 24),
                    ),
                  ) ,
                  SizedBox(
                    height: Dim().d120,
                  ),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Available:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${v['available']}',
                              style: Sty().smallText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w600,
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
                          text: "Date:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(v['date'].toString()))}',
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
                              text: ' ${v['name']}',
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
                          text: "Location: ",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${v['city']['name']}',
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
                          text: "Mobile No.:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' **********',
                              style: Sty().mediumText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: Dim().d16),
                      RichText(
                        text: TextSpan(
                          text: "Address:-",
                          style: Sty().smallText.copyWith(
                            fontSize: 14,
                            color: Clr().primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ***********************',
                              style: Sty().mediumText.copyWith(
                                  color: Clr().textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: Dim().d36),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Clr().borderColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 30,
                              offset: const Offset(8, 8),
                            ),
                          ],
                        ),
                        child: Card(
                          margin:  EdgeInsets.only(bottom: 20),
                          shape:  RoundedRectangleBorder(
                            side: BorderSide(width: 1,color: Clr().secondaryColor),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          color: const Color(0xffFFFFFF),
                          child:Padding(
                            padding: EdgeInsets.all(Dim().d16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Description',
                                    style: Sty().mediumText.copyWith(
                                        fontSize: 18,
                                        color: Clr().primaryColor, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: Dim().d16,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Requirements:- ",
                                    style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${v['requirements']}',
                                        style: Sty().smallText.copyWith(
                                            color: Clr().textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                // Text(
                                //   'Requirements:- Lorem ipsum dolor sit amet consectetur. Accumsan porttitor eu quam et nulla fermentum gravida. Lorem ipsum dolor sit amet consectetur.',
                                //   style: Sty().mediumText.copyWith(
                                //       fontSize: 16,
                                //       color: Clr().primaryColor, fontWeight: FontWeight.w400),
                                // ),
                                SizedBox(
                                  height: Dim().d16,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Budget:-",
                                    style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ₹ ${v['budget']}',
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
                                    text: "Type:-",
                                    style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${v['type']}',
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
                                    text: "Size:-",
                                    style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${v['size']}',
                                        style: Sty().mediumText.copyWith(
                                            color: Clr().textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Dim().d16),
                                RichText(
                                  text: TextSpan(
                                    text: "Comment:-",
                                    style: Sty().smallText.copyWith(
                                      fontSize: 14,
                                      color: Clr().primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${v['comments']}',
                                        style: Sty().mediumText.copyWith(
                                            color: Clr().textColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Dim().d8),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dim().d8),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Dim().d44,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),side: BorderSide(width: 0.6, color: Colors.grey)),
                                child: Center(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: Dim().d12),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Lead Cost:-",
                                        style: Sty().smallText.copyWith(
                                          fontSize: 14,
                                          color: Clr().primaryColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' ₹ ${v['lead_cost']}',
                                            style: Sty().smallText.copyWith(
                                                color: Clr().textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dim().d40,
                              width: Dim().d150,
                              child: ElevatedButton(
                                  onPressed: () {
                                    STM().redirect2page(ctx, BuyLead(leaddetails: widget.leaddeatils,));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.5,
                                      backgroundColor: Clr().primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(35))),
                                  child: Text(
                                    'Buy Lead',
                                    style: Sty().mediumText.copyWith(
                                        fontSize: 16,
                                        color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dim().d16),




                    ],
                  ),



                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       height: Dim().d16,
                  //     ),
                  //     SizedBox(
                  //       height: Dim().d48,
                  //       width: Dim().d220,
                  //       child: Card(
                  //         elevation: 1,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(35),side: BorderSide(width: 1, color:Clr().primaryColor)),
                  //         child: Center(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               SvgPicture.asset('assets/logout.svg'),
                  //               SizedBox(width: Dim().d8,),
                  //               Text(
                  //                 'Log Out',
                  //                 style: Sty().largeText.copyWith(
                  //                     color: Clr().primaryColor,
                  //                     fontWeight: FontWeight.w400,
                  //                     fontSize: 18),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: Dim().d12,
                  //     ),
                  //     Column(
                  //       children: [
                  //
                  //         Text(
                  //           'Delete My Account',
                  //           style: Sty().smallText.copyWith(
                  //               height: 1.5,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w300,
                  //               color: Clr().primaryColor),
                  //         ),
                  //         SizedBox(
                  //           height: Dim().d4,
                  //         ),
                  //         Text(
                  //           '____________',
                  //           style: Sty().smallText.copyWith(
                  //               height: -0.1,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400,
                  //               color: Clr().primaryColor),
                  //         ),
                  //         SizedBox(
                  //           height: Dim().d36,
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
