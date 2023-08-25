import 'package:chat_app/export_all.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameTextController = TextEditingController();
    final TextEditingController emailTextController = TextEditingController(text: FirebaseAuthService.auth.currentUser!.email); 

    return PageTemplate2(
      appBar: AppBar(
        clipBehavior: Clip.none,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.r,)),
      title: Text("Edit Profile", style: AppStyle.titleText,),
      ),
      child: [
        20.verticalSpace,
          Center(
            child: Stack(
              // alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 60.r,
                ),
                Positioned(
                  bottom: 0,
                  right: -8,
                  child: IconButton(onPressed: (){}, icon:  Icon(Icons.camera_alt_sharp, size: 28.r,)))
              ],
            ),
          ),
          30.verticalSpace,
          CustomTextField(
            
            controller: userNameTextController,
            hintText: "Enter a user name",
            validator: (text) {
                if (text == "") {
                  return "Please enter a email";
                } else if (!(AppConstant.isEmail(text!))) {
                  return "Please enter a valid email";
                } else {
                  return null;
                }
              },
            isPassword: false,
          ),
          10.verticalSpace,
          CustomTextField(
            readOnly: true,
            controller: emailTextController,
            hintText: "Enter a email",
            validator: (text) {
                if (text == "") {
                  return "Please enter a email";
                } else if (!(AppConstant.isEmail(text!))) {
                  return "Please enter a valid email";
                } else {
                  return null;
                }
              },
            isPassword: false,
          ),
          10.verticalSpace,
                ],
    );
  }
}