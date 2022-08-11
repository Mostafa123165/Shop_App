import 'package:flutter/material.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/modules/login_screen/login_screen.dart';
import 'package:shopapp/network/cash_helper.dart';
import 'package:shopapp/style/colors/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image ;
  final String title ;
  final String body ;


  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  }
  );
}

class OnBoardingScreen extends StatelessWidget {

   OnBoardingScreen({Key? key}) : super(key: key);

  bool islast = false ;
  List<BoardingModel>boarding =[
    BoardingModel(
      image:"assets/image/first.png",
      title:"Shop Online",
      body: "Buy by shop application " ,
    ),
    BoardingModel(
      image:"assets/image/second.png",
      title:"CreditCard",
      body: "Pay money vis creditCard" ,
    ),
    BoardingModel(
      image:"assets/image/third.png",
      title:"Thank you",
      body: "Purchase was successful" ,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var boardControler = PageController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: (){
              CashHelper.saveDate(key: 'OnBoardingScreen', value: true).then((value) {
                if(value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                          (route) => false);
                }
              });

            },
            child:const Text(
              'SKIPE',
              style: TextStyle(
                color:defaultColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged:(int index){
                    if(index == boarding.length-1){
                      islast =true ;
                    }
                    else islast =false ;
                  },
                  physics: BouncingScrollPhysics(),
                  controller:boardControler ,
                  itemBuilder:(context , index ) =>BuildItemOnBoardingScreen(boarding[index]),
                  itemCount:boarding.length,
                  ),
            ),
            const SizedBox(height: 15.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardControler ,
                    effect:const ExpandingDotsEffect(
                      dotColor:defaultColor,
                      activeDotColor: defaultColor,
                      dotHeight: 10.0 ,
                      dotWidth: 10.0 ,
                      spacing: 5.0,
                    ) ,
                    count: boarding.length
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(islast){
                      CashHelper.saveDate(key: 'OnBoardingScreen', value: true).then((value) {
                        if(value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                                  (route) => false);
                        }
                      });
                    }
                    else {
                      boardControler.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  backgroundColor: defaultColor,
                )
              ],
            ),
          ],
        ),
      )
    );

  }
  Widget BuildItemOnBoardingScreen (BoardingModel boardingItem) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage(
            '${boardingItem.image}'
          ),
        ),
      ),
      const SizedBox(
        height: 70.0,
      ),
      Text(
        '${boardingItem.title}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:20.0,
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Text(
         '${boardingItem.body}',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:20.0,
        ),
      ),
    ],
  );
}

