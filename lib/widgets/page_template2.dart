import 'package:flutter/gestures.dart';

import '../export_all.dart';

class PageTemplate2 extends StatefulWidget {
   final List<dynamic> ? child;
   final Widget ? bottomText;
   final AppBar ? appBar;
   const PageTemplate2({super.key, this.child, this.bottomText, this.appBar});

  @override
  State<PageTemplate2> createState() => _PageTemplate2State();
}

class _PageTemplate2State extends State<PageTemplate2> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppStyle.pageDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // bottomNavigationBar: widget.bottomText,
        appBar: widget.appBar,
        body: Stack(
          alignment: Alignment.center,
          children: [
           
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.83,
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
                  clipBehavior: Clip.none,
                  children: [
                    
                    
                    ...widget.child ?? []
                  ],
                ),
              ),
            ),
            
         
          ],
        ),
      ),
    );
  }
}