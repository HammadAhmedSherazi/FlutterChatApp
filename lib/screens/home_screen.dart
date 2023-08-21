import 'package:chat_app/widgets/message_user_display.dart';

import '../export_all.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  PageTemplate2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.person, color: Colors.white,)),
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
}