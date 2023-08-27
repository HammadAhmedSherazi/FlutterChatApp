import 'dart:io';

import 'package:chat_app/export_all.dart';


class ProfileScreen extends StatefulWidget {
   String? imageUrl;
   ProfileScreen({super.key, this.imageUrl});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController firstNameTextController = TextEditingController();
    final TextEditingController lastNameTextController = TextEditingController();

    final TextEditingController emailTextController = TextEditingController(text: FirebaseAuthService.auth.currentUser!.email); 
    final ImagePicker picker = ImagePicker();

  //  File ? imageFile; // Initialize the imageFile variable
  // final picker = ImagePicker();
  pickImage() async{
    
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        widget.imageUrl = pickedFile.path;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    
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
              alignment: Alignment.center,
              children: [
                
                  CircleAvatar(
                  radius: 60.r,
                  backgroundImage: widget.imageUrl != null ? widget.imageUrl!.contains('http') ?  NetworkImage(widget.imageUrl!) as ImageProvider :  FileImage(File(widget.imageUrl!)) : null  ,
                ),
                
                
                
                
                Positioned(
                  bottom: ( widget.imageUrl != null) ? 10 : null,
                  right:  ( widget.imageUrl != null) ? -10: null,
                  child: IconButton(onPressed: (){
                  pickImage();
                }, icon:  Icon(Icons.camera_alt_sharp, size:  widget.imageUrl != null  ? 28.r : 50.r,)))
              ],
            ),
          ),
          50.verticalSpace,
          CustomTextField(
            
            controller: firstNameTextController,
            hintText: "Enter a first name",
            validator: (text) {
                if (text == "") {
                  return "Please enter a username";
                } else if (!(AppConstant.isUsername(text!))) {
                  return "Please enter a valid username";
                } else {
                  return null;
                }
              },
            isPassword: false,
          ),
          10.verticalSpace,
          CustomTextField(
            
            controller: lastNameTextController,
            hintText: "Enter a last name",
            validator: (text) {
                if (text == "") {
                  return "Please enter a last name";
                } else if (!(AppConstant.isUsername(text!))) {
                  return "Please enter a valid name";
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
          30.verticalSpace,
          CustomButtonAndroid(
            buttonText: "Save",
            onTap: (){
              FirebaseAppStorage.saveProfile(File(widget.imageUrl!), '${firstNameTextController.text.trim()} ${lastNameTextController.text.trim}', emailTextController.text, context);

              // FirebaseAppStorage.fireStore.collection('users').doc(FirebaseAuthService.auth.currentUser!.uid).get().then((value) {
              //   if(value.exists){

              //   }else{
              //     AppConstant.messageDialog("User does not exist");
              //   }

              // });
            },
            height: 40.h,
          )
                ],
    );
  }
}