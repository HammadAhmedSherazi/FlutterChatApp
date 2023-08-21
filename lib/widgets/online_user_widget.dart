import 'package:chat_app/export_all.dart';

class OnlineUserWidget extends StatelessWidget {
  const OnlineUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 35.r,
            ),
            Positioned(
                bottom: 3,
                right: 5,
                child: Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 15.r,
                ))
          ],
        ),
        10.horizontalSpace
      ],
    );
  }
}
