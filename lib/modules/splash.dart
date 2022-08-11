import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key, required this.widget}) : super(key: key);
Widget widget;
@override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    // هنا عملت وقت يكون 2 ثانية
    _timer = Timer(const Duration(milliseconds: 2000), _goNext);
    // هنا لو تلاحظ قولتله ايه...
    // بعد الثانيتين go next
    // go next هنا انه يروح الـ سكرينه التانية تمام؟
  }

  _goNext() {
    // هنا الـ سكرينة ال هيروحها... اعرف بس دلوقت انها هنا هيروح سكرينه تانية وعاملها بكونستراكتور...
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
            // widget.widget دا كنسوتركتور عشان اباصيها بعدين بص كدا
            widget.widget));
  }

  @override
  void initState() {
    super.initState();
    // هنا استدعيت بقا الفانكشن بتاعة الثانيتين
    // استدعيتها فى هnitState
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // ودي سكرينه بتاعتك بالصورة ال تحطها انت بقا ok
      body: Center(
        //  هنا تغير الصورة ال انت عايزها
        child: Image(
            image: AssetImage('assets/image/splash_screen.png'),
        )),
    );
  }

  @override  // دي اي ؟
  void dispose() {
    // dispose هنا انها بعد ما ال splash screen تقفل يدي امر ان الوقت ينتهي ميستمرش...
    _timer!.cancel();
    // بقوله يكنسل الوقت بقا...
    super.dispose();
  }
}