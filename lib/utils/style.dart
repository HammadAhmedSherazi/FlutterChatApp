import 'package:chat_app/export_all.dart';
 


class AppStyle{

  //TEXT STYLE
  static final TextStyle titleText = TextStyle(
          color: Colors.white, 
          fontSize: 18.sp
        );
  static final TextStyle headStyle2 = TextStyle(
          color: Colors.black87,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500
        ); 
  static final TextStyle headStyle3 = TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500
        );  
  //DECORATION
  static BoxDecoration pageDecoration = const BoxDecoration(
  image: DecorationImage(image: AssetImage('assets/bg2.jpg'), fit: BoxFit.cover)
);
}