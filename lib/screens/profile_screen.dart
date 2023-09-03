import 'dart:developer';
import 'dart:io';

import 'package:chat_app/export_all.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatefulWidget {
  final String? imageUrl;
  final bool? isEdit;
  const ProfileScreen({super.key, this.imageUrl, this.isEdit});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();

  final TextEditingController emailTextController =
      TextEditingController(text: FirebaseAuthService.auth.currentUser!.email);
  final ImagePicker picker = ImagePicker();
  String? selectImagePath;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrl != null) {
      selectImagePath = widget.imageUrl.toString();
    }
  }

  pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectImagePath = pickedFile.path;
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18.r,
            )),
        title: Text(
          widget.isEdit != null ? "Edit Profile" : "Create Profile",
          style: AppStyle.titleText,
        ),
      ),
      child: [
        20.verticalSpace,
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 60.r,
                backgroundImage: selectImagePath != null
                    ? selectImagePath!.contains('http')
                        ? NetworkImage(selectImagePath!) as ImageProvider
                        : FileImage(File(selectImagePath!))
                    : null,
              ),
              Positioned(
                  bottom: (selectImagePath != null) ? 10 : null,
                  right: (selectImagePath != null) ? -10 : null,
                  child: IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: Icon(
                        Icons.camera_alt_sharp,
                        size: selectImagePath != null ? 28.r : 50.r,
                      )))
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
          buttonText: widget.isEdit == null ? "Save" : "Create",
          onTap: () async {
            if (widget.isEdit != null && widget.isEdit == false) {
              FirebaseAppStorage.saveProfile(
                  File(selectImagePath!),
                  '${firstNameTextController.text.trim()} ${lastNameTextController.text.trim()}',
                  emailTextController.text,
                  context);
            } else {
               FirebaseAppStorage.getUserData(emailTextController.text).then((value) => debugPrint(
                value.toString()));      
            }
          },
          height: 40.h,
        )
      ],
    );
  }
}
