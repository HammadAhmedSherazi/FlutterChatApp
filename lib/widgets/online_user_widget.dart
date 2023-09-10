import 'package:chat_app/export_all.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OnlineUserWidget extends StatelessWidget {
  final double ? radius;
  final String imageUrl;
  final bool isOnline;
  const OnlineUserWidget({super.key, this.radius, required this.imageUrl, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) =>  CircleAvatar(
                // backgroundColor: Colors.amber,
                backgroundImage: AssetImage("${AppConstant.imagePath}user_avatar.jpg"),
                radius: radius ?? 35.r,
              ),
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
                radius:radius ?? 35.r,
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                // backgroundColor: Colors.amber,
                backgroundImage: AssetImage("${AppConstant.imagePath}user_avatar.jpg"),
                radius: radius ?? 35.r,
              ),
            ),
            if(isOnline)
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
