import '../export_all.dart';

class PageTemplate1 extends StatefulWidget {
   final List<dynamic> ? child;
   final Widget ? bottomText;
   const PageTemplate1({super.key, this.child, this.bottomText});

  @override
  State<PageTemplate1> createState() => _PageTemplate1State();
}

class _PageTemplate1State extends State<PageTemplate1> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: pageDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // bottomNavigationBar: widget.bottomText,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 30,
              child: Image.asset('assets/appIcon.png', width: 120, height: 120,)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.73,
                padding: const EdgeInsets.all(15.0),

                decoration:   BoxDecoration(
                  color: Colors.white,
                  boxShadow:  [
                    BoxShadow(
                      blurRadius: 0.6,
                      color: Colors.black.withOpacity(0.5)
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.asset('assets/chitChat.png', width: 70, height: 70,),
                    10.verticalSpace,
                    ...widget.child! as List
                  ],
                ),
              ),
            ),
            
            Positioned(
              bottom: 30,
              child: widget.bottomText!)
          ],
        ),
      ),
    );
  }
}