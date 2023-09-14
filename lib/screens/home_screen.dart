import 'package:chat_app/providers/user_info_provider.dart';

import '../export_all.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // @override

  @override
  Widget build(BuildContext context) {
    return PageTemplate2(
      drawer: appdrawer(context),
      // key: AppConstant.formKeyList[2],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.none,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              )),
        ),
        title: Text(
          "Chit Chat",
          style: AppStyle.titleText,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      child: [
        Text(
          "Online Friends",
          style: AppStyle.headStyle2,
        ),
        10.verticalSpace,
        Consumer(builder: (context, ref, child) {
          final onlineUser =
              ref.watch(fetchAllUserProvider(FirebaseAuthService.auth.currentUser!.email!));
          return onlineUser.when(
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => Text(error.toString()),
            data : (users){
              // log(users.toString());
              return SizedBox(
            height: 100.h,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => MessagingScreen(
                    userActive:users[index]!.isOnline ,
                    userImageUrl: users[index]!.imageUrl,
                    username: users[index]!.username,
                  ),)),
                  child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           OnlineUserWidget(
                            imageUrl: users[index]!.imageUrl!,
                            isOnline: users[index]!.isOnline!,
                          ),
                          5.verticalSpace,
                          Text(
                            users[index]!.username!,
                            style: AppStyle.headStyle3,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                ),
                separatorBuilder: (context, index) => 5.horizontalSpace,
                itemCount: users.length),
          );
        
            }
          );
           }),
        20.verticalSpace,
        Text(
          "Messages",
          style: AppStyle.headStyle2,
        ),
        10.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          itemCount: 5,
          separatorBuilder: (context, index) => 10.verticalSpace,
          itemBuilder: (context, index) => const UserMessageDisplay(),
          physics: const NeverScrollableScrollPhysics(),
        )
      ],
    );
  }

  Drawer appdrawer(BuildContext context) {
    return Drawer(
      clipBehavior: Clip.none,
      backgroundColor: Colors.white,
      width: MediaQuery.sizeOf(context).width * 0.7,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
      ),
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final AsyncValue userDataProvider =
                  ref.watch(fetchUserProvider(FirebaseAppStorage.uid));
              return userDataProvider.when(
                data: (data) {
                  return Expanded(
                    flex: 3,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        OnlineUserWidget(
                          imageUrl: data.imageUrl,
                          radius: 60.r,
                          isOnline: true,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: RawMaterialButton(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.all(20.r),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  ProfileScreen(
                                      isEdit: true,
                                      imageUrl: data.imageUrl,
                                      
                                    ),
                                  ));
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: ColorsApp.kButtonColor,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20.r,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 50,
                        //   right: -25,
                        //   child: RawMaterialButton(
                        //     shape: const CircleBorder(),
                        //     onPressed:() {
                        //     Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfileScreen(
                        //       isEdit: true,
                        //       // imageUrl: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                        //     ),));
                        //   },
                        //   child: CircleAvatar(
                        //     radius: 20.r,
                        //     backgroundColor: ColorsApp.kButtonColor,
                        //     child: Icon(Icons.edit, color: Colors.white, size: 20.r,),
                        //   ),
                        //   )
                        //   ),
                        // 10.verticalSpace,
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.username,
                                  style: AppStyle.headStyle2,
                                ),
                              ],
                            ))
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => profileLoaderWidget(context),
                loading: () => profileLoaderWidget(context),
              );
            },
          ),
          Expanded(
            flex: 6,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: DrawerItem.itemList.length,
              itemBuilder: (context, index) => DrawerItem.itemList[index],
            ),
          ),
          Container(
            height: 45,
            // padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 60, bottom: 40),
            decoration: BoxDecoration(
                color: ColorsApp.kButtonColor,
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(30))),
            child: ListTile(
              onTap: () {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return WillPopScope(
                        onWillPop: () async => false,
                        child: AlertDialog(
                          alignment: Alignment.center,
                          contentPadding: const EdgeInsets.only(
                            bottom: 0,
                            top: 10,
                            // right: 10,
                            // left : 10
                          ),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Are You Sure!",
                                textAlign: TextAlign.center,
                              ),
                              15.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        FirebaseAuthService.auth.signOut().then(
                                            (value) => Navigator
                                                .pushNamedAndRemoveUntil(
                                                    context,
                                                    "/LoginScreen",
                                                    (route) => false));
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: ColorsApp.kButtonColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                );
              },
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              leading: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.white,
                size: 21.r,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded profileLoaderWidget(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('${AppConstant.imagePath}user_avatar.jpg'),
              onBackgroundImageError: (exception, stackTrace) =>
                  AssetImage('${AppConstant.imagePath}user_avatar.jpg'),

              // backgroundColor: ColorsApp.kButtonColor,
            ),
            Align(
              alignment: Alignment.topRight,
              child: RawMaterialButton(
                shape: const CircleBorder(),
                padding: EdgeInsets.all(20.r),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(
                          isEdit: true,
                          // imageUrl:
                        ),
                      ));
                },
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: ColorsApp.kButtonColor,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 50,
            //   right: -25,
            //   child: RawMaterialButton(
            //     shape: const CircleBorder(),
            //     onPressed:() {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfileScreen(
            //       isEdit: true,
            //       // imageUrl: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
            //     ),));
            //   },
            //   child: CircleAvatar(
            //     radius: 20.r,
            //     backgroundColor: ColorsApp.kButtonColor,
            //     child: Icon(Icons.edit, color: Colors.white, size: 20.r,),
            //   ),
            //   )
            //   )
          ],
        ));
  }
}

class DrawerItem extends StatelessWidget {
  final String itemtitle;
  final IconData icon;
  final VoidCallback Function(BuildContext context) onTap;

  // static BuildContext ? context;

  const DrawerItem(
      {super.key,
      required this.itemtitle,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap(context),
      leading: Icon(
        icon,
        color: ColorsApp.kButtonColor,
      ),
      title: Text(
        itemtitle,
        style: TextStyle(
            color: ColorsApp.kButtonColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  static final List<DrawerItem> itemList = [
    DrawerItem(
      itemtitle: "Home",
      icon: Icons.home,
      onTap: (context) => Navigator.of(context).pop,
    ),
    DrawerItem(
      itemtitle: "Friend Request",
      icon: Icons.person_add_alt_rounded,
      onTap: (context) => Navigator.of(context).pop,
    ),
    DrawerItem(
      itemtitle: "Notification",
      icon: Icons.notifications,
      onTap: (context) => Navigator.of(context).pop,
    ),
    DrawerItem(
      itemtitle: "Setting",
      icon: Icons.settings,
      onTap: (context) => Navigator.of(context).pop,
    )
  ];
}
