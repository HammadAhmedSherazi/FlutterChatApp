import '../export_all.dart';

class UserMessageDisplay extends StatelessWidget {
  const UserMessageDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
              visualDensity: const VisualDensity(
                horizontal: -4.0,
                
              ),
              horizontalTitleGap:1.8 ,
              contentPadding: EdgeInsets.zero,
              leading: const  OnlineUserWidget(
                imageUrl: '',
                isOnline: false,
              ),
              title: Text("User name", style: AppStyle.headStyle2,),
              subtitle: const Text("last message..."),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("00:00", style: TextStyle(
                    fontSize: 10.sp
                  ),),
                  CircleAvatar(
                    radius: 11.r,
                    backgroundColor: ColorsApp.kButtonColor,
                    child:  Text("1", style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp
                    ),),
                  )

                ],
              ),
            )
          ;
  }
}