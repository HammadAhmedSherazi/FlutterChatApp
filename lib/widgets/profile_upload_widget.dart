import 'dart:io';

import 'package:chat_app/export_all.dart';

class ProfileImageUploadWidget extends StatefulWidget {
  final String? imageUrl;
  const ProfileImageUploadWidget({super.key, this.imageUrl});

  @override
  State<ProfileImageUploadWidget> createState() => _ProfileImageUploadWidgetState();
}

class _ProfileImageUploadWidgetState extends State<ProfileImageUploadWidget> {
  final ImagePicker picker = ImagePicker();

   File ? imageFile; // Initialize the imageFile variable
  // final picker = ImagePicker();
  pickImage() async{
    
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
              alignment: Alignment.center,
              children: [
                
                  CircleAvatar(
                  radius: 60.r,
                  backgroundImage: widget.imageUrl != null ? widget.imageUrl!.contains('http') ?  NetworkImage(widget.imageUrl!) as ImageProvider :  FileImage(imageFile!) : null  ,
                ),
                
                
                
                
                Positioned(
                  bottom: ( widget.imageUrl != null) ? 10 : null,
                  right:  ( widget.imageUrl != null) ? -10: null,
                  child: IconButton(onPressed: (){
                  pickImage();
                }, icon:  Icon(Icons.camera_alt_sharp, size:  widget.imageUrl != null  ? 28.r : 50.r,)))
              ],
            );
  }
}