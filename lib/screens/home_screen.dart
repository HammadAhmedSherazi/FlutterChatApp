import 'package:chat_app/widgets/message_user_display.dart';

import '../export_all.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  PageTemplate2(
      
      drawer: appdrawer(context),
      // key: AppConstant.formKeyList[2],
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        clipBehavior: Clip.none,
        leading: Builder(builder: (context) => IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: const Icon(Icons.person, color: Colors.white,)),),
        title: Text("Chit Chat", style: AppStyle.titleText,),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(
            Icons.search,
            color: Colors.white,
          ))
        ],
      ),
      child: [
        Text("Online Friends", style: AppStyle.headStyle2,),
        10.verticalSpace,
        SingleChildScrollView(
          clipBehavior: Clip.none,
          
          padding: EdgeInsets.symmetric(
            horizontal: 10.r
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (index) => const OnlineUserWidget()),
          ),
        ),
        20.verticalSpace,
        Text("Messages", style: AppStyle.headStyle2,),
        10.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          itemCount: 5,
          separatorBuilder:(context, index) => 10.verticalSpace,
          itemBuilder: (context, index) => const UserMessageDisplay(),
          physics: const NeverScrollableScrollPhysics(),
          
        )

      ],
    );
  }
  Drawer appdrawer(BuildContext context){
      return Drawer(
      clipBehavior: Clip.none,
      backgroundColor: Colors.white,
      width: MediaQuery.sizeOf(context).width * 0.7, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50)
        ),
    
         
      ),
    );
  }
  
  
}