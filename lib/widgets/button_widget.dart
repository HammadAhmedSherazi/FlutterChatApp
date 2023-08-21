import '../export_all.dart';

class CustomButtonAndroid extends StatelessWidget {
  final String? buttonText;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  const CustomButtonAndroid(
      {super.key, this.buttonText, this.height, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(ColorsApp.kButtonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            
          ))),
          
          child: Text(
            buttonText!,
            style:
                TextStyle(color: ColorsApp.kButtonTextColor, fontSize: 14.sp),
          )),
    );
  }
}
