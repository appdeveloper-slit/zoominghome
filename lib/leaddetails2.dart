import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoominghome/home.dart';
import 'package:zoominghome/manage/static_method.dart';
import 'package:zoominghome/myleads.dart';
import 'package:zoominghome/sidedrawer.dart';
import 'package:zoominghome/values/strings.dart';
import 'buylead.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class LeadDetails2 extends StatefulWidget {
  final dynamic details;
  final dynamic leaddetails;
  final dynamic myleaddetails;
  const LeadDetails2({super.key,this.details,this.leaddetails,this.myleaddetails});

  @override
  State<LeadDetails2> createState() => _LeadDetails2State();
}

class _LeadDetails2State extends State<LeadDetails2> {
  late BuildContext ctx;
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
   var leaddetaails,details,myleaddetails;
  String? Token;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      Token = sp.getString('token') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        // getCity();
        refundList();
        print(Token);
      }
    });
  }
   @override
  void initState() {
    // TODO: implement initState
     details = widget.details;
     leaddetaails = widget.leaddetails;
     myleaddetails = widget.myleaddetails;
     getSession();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: ()async{
        myleaddetails != null ? STM().back2Previous(ctx) : STM().finishAffinity(ctx, const HomePage());
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
                  SizedBox(
                    height: Dim().d36,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: (){
                            myleaddetails != null ? STM().back2Previous(ctx) : STM().finishAffinity(ctx, const HomePage());
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
                leaddetaails == null ? details == null ?  myleadLayout()  : myleadLayout() : layoutDetails(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // this layout show when redirect to buyleads
  Widget layoutDetails() {
     return Column(
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
                 text: ' ${leaddetaails['available']}',
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
                 text: ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(leaddetaails['date'].toString()))}',
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
                 text: ' ${leaddetaails['name']}',
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
                 text: ' ${leaddetaails['city']['name']}',
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
                 text: ' ${leaddetaails['mobile'].toString()}',
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
                 text: ' ${leaddetaails['address'].toString()}',
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
                           text: '${leaddetaails['requirements'].toString()}',
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
                           text: ' ₹ ${leaddetaails['budget'].toString()}',
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
                           text: ' ${leaddetaails['type'].toString()}',
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
                           text: ' ${leaddetaails['size'].toString()}',
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
                           text: ' ${leaddetaails['comments'].toString()}',
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


         SizedBox(
           height: Dim().d8,
         ),
         RichText(
           text: TextSpan(
             text: "No. of Leads Purchased:-",
             style: Sty().smallText.copyWith(
               fontSize: 14,
               color: Clr().primaryColor,
               fontWeight: FontWeight.w400,
             ),
             children: <TextSpan>[
               TextSpan(
                 text: ' ${details['no_of_leads'].toString()}',
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
             text: "Cost Per Lead:-",
             style: Sty().smallText.copyWith(
               fontSize: 14,
               color: Clr().primaryColor,
               fontWeight: FontWeight.w400,
             ),
             children: <TextSpan>[
               TextSpan(
                 text: ' ₹ ${leaddetaails['lead_cost'].toString()}',
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
             text: "Transaction ID:-",
             style: Sty().smallText.copyWith(
               fontSize: 14,
               color: Clr().primaryColor,
               fontWeight: FontWeight.w400,
             ),
             children: <TextSpan>[
               TextSpan(
                 text: ' ${details['transaction_id'].toString()}',
                 style: Sty().smallText.copyWith(
                     color: Clr().textColor,
                     fontWeight: FontWeight.w500,
                     fontSize: 15),
               ),
             ],
           ),
         ),
         SizedBox(height: Dim().d16),
         Row(
           children: [
             SizedBox(
               height: Dim().d44,
               child: Card(
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(35),side: BorderSide(width: 1, color: Clr().primaryColor)),
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                   child: Center(
                     child: RichText(
                       text: TextSpan(
                         text: "Total Amount:-",
                         style: Sty().smallText.copyWith(
                           fontSize: 14,
                           color: Clr().primaryColor,
                           fontWeight: FontWeight.w400,
                         ),
                         children: <TextSpan>[
                           TextSpan(
                             text: ' ₹ ${details['total_amount']}',
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
           ],
         ),
         SizedBox(height: Dim().d16),
       Align(
           alignment: Alignment.center,
           child: SizedBox(
             height: Dim().d40,
             width: Dim().d180,
             child: ElevatedButton(
                 onPressed: () {
                   plansDialog(ctx);
                   // STM().redirect2page(ctx, CouponCode());
                 },
                 style: ElevatedButton.styleFrom(
                     elevation: 0.5,
                     backgroundColor: Clr().primaryColor,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(35))),
                 child: Text(
                   'Request Refund',
                   style: Sty().mediumText.copyWith(
                       fontSize: 16,
                       color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                 )),
           ),
         ) ,
         SizedBox(height: Dim().d16),
       ],
     );
  }

  // layout show when redirect to myleads
  Widget myleadLayout(){
    return Column(
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
                text: ' ${myleaddetails['lead_available']}',
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
                text: ' ${DateFormat('dd MMM yyyy').format(DateTime.parse(myleaddetails['buy_date'].toString()))}',
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
                text: ' ${myleaddetails['lead_name']}',
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
                text: ' ${myleaddetails['lead_city']}',
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
                text: ' ${myleaddetails['lead_mobile'].toString()}',
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
                text: ' ${myleaddetails['lead_address'].toString()}',
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
                          text: '${myleaddetails['lead_requirement'].toString()}',
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
                          text: ' ₹ ${myleaddetails['lead_budget'].toString()}',
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
                          text: ' ${myleaddetails['lead_type'].toString()}',
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
                          text: ' ${myleaddetails['lead_size'].toString()}',
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
                          text: ' ${myleaddetails['lead_comments'].toString()}',
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


        SizedBox(
          height: Dim().d8,
        ),
        RichText(
          text: TextSpan(
            text: "No. of Leads Purchased:-",
            style: Sty().smallText.copyWith(
              fontSize: 14,
              color: Clr().primaryColor,
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' ${myleaddetails['no_of_leads'].toString()}',
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
            text: "Cost Per Lead:-",
            style: Sty().smallText.copyWith(
              fontSize: 14,
              color: Clr().primaryColor,
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' ₹ ${myleaddetails['lead_cost'].toString()}',
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
            text: "Transaction ID:-",
            style: Sty().smallText.copyWith(
              fontSize: 14,
              color: Clr().primaryColor,
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' ${myleaddetails['transaction_id'].toString()}',
                style: Sty().smallText.copyWith(
                    color: Clr().textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(height: Dim().d16),
        Row(
          children: [
            SizedBox(
              height: Dim().d44,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),side: BorderSide(width: 1, color: Clr().primaryColor)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Total Amount:-",
                        style: Sty().smallText.copyWith(
                          fontSize: 14,
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ₹ ${myleaddetails['total_amount']}',
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
          ],
        ),
        SizedBox(height: Dim().d16),
        myleaddetails['refund_status'] == null ? Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: Dim().d40,
            width: Dim().d180,
            child: ElevatedButton(
                onPressed: () {
                  plansDialog(ctx);
                  // STM().redirect2page(ctx, CouponCode());
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0.5,
                    backgroundColor: Clr().primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35))),
                child: Text(
                  'Request Refund',
                  style: Sty().mediumText.copyWith(
                      fontSize: 16,
                      color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                )),
          ),
        ) : Container(),
        SizedBox(height: Dim().d16),
      ],
    );
  }


  String? GenderValue;
  List<dynamic> BusinessCatList = [];
  plansDialog(ctx) {
    AwesomeDialog(
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      isDense: true,
      body: StatefulBuilder(builder: (BuildContext context, setState) {
        return Container(
          padding: EdgeInsets.all(Dim().d4),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d16),
            child: Column(
              children: [
                SizedBox(
                  height: Dim().d8,
                ),
                Text(
                  'Request Refund',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Sty().smallText.copyWith(
                      height: 1.2,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Clr().primaryColor),
                ),
                SizedBox(
                  height: Dim().d28,
                ),
                Container(
                  height: Dim().d52,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    // color: Clr().white,
                      boxShadow: [
                        BoxShadow(
                          color: Clr().grey.withOpacity(0.1),
                          spreadRadius: 0.5,
                          blurRadius: 12,
                          offset: Offset(0, 4),  // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Clr().primaryColor,)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: GenderValue,
                      hint:Text('Select an Issue*',style: Sty().mediumText.copyWith(
                        color: Clr().textColor,
                      ),),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 28,
                        color: Clr().primaryColor,
                      ),
                      style: TextStyle(color: Color(0xff787882)),
                      items: BusinessCatList.map((string) {
                        return DropdownMenuItem(
                          value: string['reason'],
                          child: Text(
                            string['reason'],
                            style:
                            Sty().mediumText.copyWith(
                              color: Clr().textColor,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (t) {
                        // STM().redirect2page(ctx, Home());
                        setState(() {
                          GenderValue = t.toString();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Dim().d28,
                ),
                Align(
                  alignment: Alignment.center,
                  child:  SizedBox(
                    height: Dim().d40,
                    width: Dim().d180,
                    child: ElevatedButton(
                        onPressed: () {
                          requestRefund();
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0.5,
                            backgroundColor: Clr().primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35))),
                        child: Text(
                          'Submit',
                          style: Sty().mediumText.copyWith(
                              fontSize: 16,
                              color: Clr().secondaryColor, fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
                SizedBox(
                  height: Dim().d28,
                ),
              ],
            ),
          ),
        );
      }),
    ).show();
  }


  void requestRefund() async {
    FormData body = FormData.fromMap({
      'buy_lead_id': details == null ? myleaddetails['buy_lead_id'] : details['id'],
      'refund_reason': GenderValue,
      'paid_amount': details == null ?  myleaddetails['total_amount'] : details['total_amount'],
    });
    var result = await STM().posttoken(ctx, Str().processing, 'requestRefund', body, Token);
    var status = result['status'];
    var message = result['message'];
    if(status){
     leaddetaails == null ? STM().successDialogWithReplace(ctx, message, MyLeads(type: 'refund',)) : STM().successDialogWithAffinity(ctx, message, HomePage());
    }else{
      STM().errorDialog(ctx, message);
    }
  }


  // refund list
 void refundList() async {
    var result = await STM().getWithoutDialog(ctx, 'refund_reason');
    setState(() {
      BusinessCatList = result['refund_reason'];
    });
 }


}
