import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Clot Geshe
// Clot Geshe House | CGHouse | clotgeshe
class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Card(
              elevation: 6,
              margin: const EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: SizedBox(
                          height: 22,
                          child: OutlineButton(
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            borderSide: BorderSide(color: Colors.black),
                            highlightedBorderColor: Colors.black,
                            splashColor: Colors.black12,
                            highlightColor: Colors.black12,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 12),
                            child: Text(
                              'Email',
                              // style: TextStyle(
                              //   fontWeight: FontWeight.bold,
                              //   fontSize: 18,
                              //   color: Colors.black,
                              // ),
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: PrimaryColorOverride(
                              color: Colors.blueAccent,
                              child: TextField(
                                strutStyle:
                                    StrutStyle(fontStyle: FontStyle.italic),
                                textInputAction: TextInputAction.search,
                                cursorColor: Colors.blueAccent,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(FontAwesomeIcons.user),
                                  hintText: 'Your Email',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 12),
                            child: Text(
                              'Password',
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: PrimaryColorOverride(
                              color: Colors.blueAccent,
                              child: TextField(
                                obscureText: true,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  hintText: 'Enter Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: OutlineButton(
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent),
                                    highlightedBorderColor: Colors.blueAccent,
                                    splashColor:
                                        Colors.blueAccent.withOpacity(0.25),
                                    highlightColor:
                                        Colors.blueAccent.withOpacity(0.25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: FlatButton(
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.blueAccent,
                                    splashColor: Colors.blueAccent.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}

// class GosheOutlineButton extends StatelessWidget {
//   const GosheOutlineButton({
//     Key key,
//     this.title,
//     this.onPressed,
//   }) : super(key: key);

//   final String title;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return OutlineButton(
//       padding: EdgeInsets.zero,
//       clipBehavior: Clip.antiAlias,
//       borderSide: BorderSide(
//         color: Colors.blueAccent,
//         width: 2.5,
//       ),
//       highlightedBorderColor: Colors.blueAccent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(6),
//         ),
//       ),
//       highlightColor: Color(0x3f2979FF),
//       splashColor: Color(0x7f2979FF),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 28),
//         color: Color(0x1f2979FF),
//         child: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//         ),
//       ),
//       onPressed: onPressed,
//     );
//   }
// }
