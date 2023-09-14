import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/export_all.dart';


class MessagingScreen extends StatelessWidget {
  final String ? userImageUrl;
  final String ? username;
  final bool ? userActive;
  const MessagingScreen({super.key, this.username, this.userImageUrl, this.userActive});

  @override
  Widget build(BuildContext context) {
    return PageTemplate2(
      bottomWidget: Container(
        
        padding: EdgeInsets.symmetric(
          horizontal: 20.r
        ),
        // color: ColorsApp.kButtonColor,
        height: 80.h,
        // width: MediaQuery.sizeOf(context).width,
        child:  Row(
          children: [
           const  Expanded(child:  CustomTextField(
              hintText: 'Enter a message...',
            )),
            GestureDetector(
              onTap: (){},
              child: Container(
                width: 50.r,
                height: 50.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsApp.kButtonColor
                ),
                child: const Icon(Icons.send, color: Colors.white,),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: MediaQuery.sizeOf(context).width,


      
        leading: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 10.r
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                shape: const CircleBorder(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chevron_left, color: Colors.white, size: 35.r,),
                    OnlineUserWidget(imageUrl: userImageUrl!, isOnline: userActive!),
                  ],
                ),
              ),
              // 5.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(username!, style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp
                  ),),
                  Text('Last seen time', style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp
                  ),)
                ],
              )
            ],
          ),
        ) 
        // leading: ListTile(
        //   leading: SizedBox(
        //     height: 30.r,
        //     width: 30.r,
        //     child: CachedNetworkImage(imageUrl: userImageUrl!, imageBuilder: (context, imageProvider) => CircleAvatar(
        //       backgroundImage: imageProvider,
        //       radius: 30.r,
        //     ),
        //     errorWidget: (context, url, error) => CircleAvatar(
        //       backgroundImage: AssetImage('${AppConstant.imagePath}user_avatar.png'),
        //       radius: 30.r,
        //     ),
        //     placeholder: (context, url) => CircleAvatar(
        //       backgroundImage: AssetImage('${AppConstant.imagePath}user_avatar.png'),
        //       radius: 30.r,
        //     ),
        //      ),
        //   )           
        //   ,title: Text(username!),
        //   // tileColor: Colors.white,
        //   titleTextStyle: TextStyle(
        //     color: Colors.white,
        //     fontSize: 15.sp
        //   ),
        // ),
      
      ),
      // physics: const NeverScrollableScrollPhysics(),
      child: const [
         Center(
        child: Text('Message Section'),
        ),
        

      ],
    );
  }
}