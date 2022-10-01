import 'package:ecommerce/constants/app_constants.dart';
import 'package:ecommerce/constants/colors_constants.dart';
import 'package:ecommerce/repositories/auth/bloc/authentication_bloc.dart';
import 'package:ecommerce/repositories/auth/model/user_model.dart';
import 'package:ecommerce/utils/helpers/internet/internet_cubit.dart';
import 'package:ecommerce/utils/modules/home/bloc/home_bloc.dart';
import 'package:ecommerce/utils/modules/home/widgets/categories_list_widget.dart';
import 'package:ecommerce/utils/modules/home/widgets/second_list_widget.dart';
import 'package:ecommerce/utils/modules/home/widgets/top_list_widget.dart';
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:ecommerce/utils/ui/custom_elevated_button.dart';
import 'package:ecommerce/utils/ui/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AuthenticationBloc authenticationBloc;
  SharedPreference sharedPreference = SharedPreference();
  late HomeBloc bloc;

  @override
  void initState() {
    authenticationBloc=context.read<AuthenticationBloc>();
    bloc=context.read<HomeBloc>();
    bloc.add(const LoadData());
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print("state.message");
            if(state.homeStateStatus ==  HomeStateStatus.successHome){
              return Scaffold(
                backgroundColor: Colors.white,
                key: _scaffoldKey,
                drawer: Drawer(
                  elevation: 20,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                  backgroundColor: appBackgroundColor,

                  child: ListView(
                    padding: const EdgeInsets.only(top: 0.0),

                    children: [
                      SizedBox(

                        height: 250,

                        width: double.infinity,

                        // color: Colors.black,

                        child: Stack(children: [

                          Container(

                              height: 200,

                              decoration: BoxDecoration(

                                  image: DecorationImage(

                                      colorFilter: ColorFilter.mode(

                                          primaryColorDark.withOpacity(.8),

                                          BlendMode.darken),

                                      fit: BoxFit.cover,

                                      image: const AssetImage("assets/images/bg-top.jpg")),

                                  color: primaryColorDark,

                                  boxShadow: const [BoxShadow(blurRadius: 15)],

                                  borderRadius: const BorderRadius.only(

                                      bottomRight: Radius.circular(150))),

                              padding: const EdgeInsets.all(10),

                              width: double.infinity,

                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [

                                  Padding(

                                    padding: const EdgeInsets.only(right: 50),

                                    child:Text(state.userName,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,

                                            fontSize: 18),
                                        maxLines: 2),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 12.0,right: 50),
                                    child: Text(state.userEmail,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 13),
                                      maxLines: 2,),
                                  ),

                                ],

                              )),
                          Positioned(

                            bottom: 0,

                            left: 50,

                            child: Align(

                              alignment: Alignment.bottomCenter,

                              child: Container(

                                height: 100,

                                width: 100,

                                decoration: const BoxDecoration(
                                  color: Colors.grey,

                                  shape: BoxShape.circle,

                                  boxShadow: [

                                    BoxShadow(blurRadius: 7, offset: Offset(0, 3))

                                  ],
                                )   ,
                                child: const CircleAvatar(
                                    radius: 50,
                                    backgroundColor:Colors.white70,
                                    foregroundImage:AssetImage("assets/images/avatar.png")
                                ),
                              ),

                            ),

                          )
                        ]
                        ),

                      ),
                      const SizedBox(height: 20,),

                      ListTile(
                        title: const Text('Copy Token',),
                        selectedColor: primaryColorDark,
                        textColor: primaryColorDark,
                        iconColor: primaryColorDark,

                        leading: const Icon(Icons.token),
                        onTap: () async {
                          String token = await SharedPreference().readString("fcm_token");
                          if(token.isNotEmpty){
                            await Clipboard.setData(ClipboardData(text: token));
                            showSnackBarMessage(context, "Firebase token successfully. Now you can paste this token in firebase console and test push notification");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  centerTitle: true,

                  leading: IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: (){
                        _scaffoldKey.currentState!.openDrawer();
                      }),
                  title: const Text("E Commerce"),
                  actions: <Widget>[
                    IconButton(
                        icon: Image.asset("assets/images/power_off.png",
                            height: 24,
                            color: Colors.white),
                        onPressed: (){
                          authenticationBloc.add(AuthenticationLogoutRequested());
                        }),
                    const SizedBox(width: 5,)
                  ],
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            width: double.infinity,
                            height: 57,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: searchBackgroundColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10,),
                                Image.asset("assets/images/home_static_assets/search_icon.png",
                                  width: 22,),
                                const SizedBox(width: 20,),
                                const Text("Search",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: searchTextColor
                                  ),),
                                const Spacer(),
                                Image.asset("assets/images/home_static_assets/mic_icon.png",
                                  width: 24,
                                  height: 24,),

                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height:220,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              primary: false,
                              itemCount: state.topList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TopListWidget(topList: state.topList[index],index: index,buildContext: context);
                              }),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height:220,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              primary: false,
                              itemCount: state.secondList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SecondListWidget(secondList: state.secondList[index],index: index,buildContext: context);
                              }),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                              "Categories",
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                  overflow:TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,color: Colors.black)
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height:235,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              primary: false,
                              itemCount: state.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CategoriesListWidget(categories: state.categories[index],index: index,buildContext: context);
                              }),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color(0xff49454F),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child:Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 70,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 5,),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffD0BCFF)
                                          ),
                                          child: const Center(
                                            child: Text("A",
                                            style: TextStyle(
                                              color: Color(0xff1C1B1F),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22
                                            ),),
                                          ),
                                        ),
                                        const SizedBox(width: 15,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text("Title header",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Color(0xffE6E1E5)
                                              ),),
                                            Text("Subhead",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Color(0xffE6E1E5)
                                              ),),
                                          ],
                                        ),
                                        const Spacer(),
                                        Image.asset("assets/images/home_static_assets/title_icon.png",
                                          width: 20,
                                          height: 20),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ),
                                Image.asset("assets/images/home_static_assets/title_image.png",
                                    width: double.infinity),
                                const SizedBox(height: 15),

                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text("Title",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xffE6E1E5)
                                    ),),
                                ),
                                const SizedBox(height: 5),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text("Subhead",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xffE6E1E5)
                                    ),),
                                ),
                                const SizedBox(height: 30),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xffE6E1E5)
                                    ),),
                                ),
                                const SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xff49454F),
                                            border: Border.all(color:Color(0xffD0BCFF),width: 1),
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                                          child: Center(
                                            child: Text("Action",
                                            style: TextStyle(
                                              color:  Color(0xffD0BCFF),
                                              fontSize: 12
                                            ),),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xffD0BCFF),
                                            border: Border.all(color:const Color(0xffD0BCFF),width: 1),
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                                          child: Center(
                                            child: Text("Action",
                                            style: TextStyle(
                                              color:  Color(0xff49454F),
                                              fontSize: 12
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            }
            else if(state.homeStateStatus ==  HomeStateStatus.failureHome){
              return Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Cannot Load Home Data",
                        style: TextStyle(
                            color: primaryColorDark,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  )
              );}
            else {
              return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: Colors.white,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
              );
            }
        });
  }

}

void hideKeyBoard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void showSnackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message)),
    );
}

