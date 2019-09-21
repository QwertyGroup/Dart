import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

// Clot Geshe
// Clot Geshe House | CGHouse | clotgeshe
class SignIn extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  final store = Firestore.instance;
  final googleSignIn = GoogleSignIn();

  Observable<FirebaseUser> user$;
  Observable<Map<String, dynamic>> profile$;
  PublishSubject loading = PublishSubject();

  SignIn({Key key}) : super(key: key) {
    user$ = Observable(auth.onAuthStateChanged);

    profile$ = user$.switchMap((FirebaseUser u) {
      if (u != null) {
        return store
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just(null);
      }
    });
  }

  @override
  _SignInState createState() => _SignInState();

  Future<FirebaseUser> signIn() async {
    loading.sink.add(true);
    var googleUser = await googleSignIn.signInSilently();
    if (googleUser == null) {
      googleUser = await googleSignIn.signIn();
    }
    if (googleUser == null) return Future.value(null);
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final fireUser = await auth.signInWithCredential(credential);

    updateUserData(fireUser.user);
    print('signed in ${fireUser.user.displayName}');
    loading.add(false);
    return fireUser.user;
  }

  Future<FirebaseUser> signInLogin() async {
    loading.sink.add(true);
    // auth.createUserWithEmailAndPassword(email: '', password: '');
    final fireUser = await auth.signInWithEmailAndPassword(
        email: 'hello@gmail.com', password: 'hello1world5');

    // updateUserData(fireUser.user);
    print('signed in ${fireUser.user.displayName}');
    loading.add(false);
    return fireUser.user;
  }

  void updateUserData(FirebaseUser user) {
    store.runTransaction((transaction) async {
      final ref = store.collection('users').document(user.uid);
      final fresh = await transaction.get(ref);
      await transaction.set(
        fresh.reference,
        {
          'uid': user.uid,
          'email': user.email,
          'photo': user.photoUrl,
          'name': user.displayName,
          'lastSeen': DateTime.now().toUtc(),
        },
      );
    });
  }

  void signOut() async {
    auth.signOut();
    if (await googleSignIn.isSignedIn()) {
      googleSignIn.signOut();
      // googleSignIn.disconnect();
    }
  }
}

class _SignInState extends State<SignIn> {
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // textBaseline: TextBaseline.ideographic,
                    children: [
                      StreamBuilder(
                        stream: widget.profile$,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Text(
                              snapshot.data['name'],
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                            );
                          } else
                            return Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder(
                          stream: widget.profile$,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final photo = snapshot.data['photo'];
                              if (photo != null)
                                return SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: ClipOval(
                                    child: Image.network(photo),
                                  ),
                                );
                              else {
                                String name = snapshot.data['name'];
                                name = name
                                    .split(' ')
                                    .where((i) => i.length > 1)
                                    .fold('', (acc, i) => acc += i[0]);
                                return SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.amber,
                                      child: Center(
                                          child: Text(
                                        // '${name[0]}${name[name.length - 1]}'
                                        name.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Exo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                );
                              }
                            } else
                              return Container();
                          },
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
                                // LinearProgressIndicator(),
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
                                    onPressed: () {
                                      widget.signInLogin();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: StreamBuilder(
                                    stream: widget.user$,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return OutlineButton(
                                          child: const Text(
                                            'Sign Out',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          highlightedBorderColor: Colors.black,
                                          splashColor: Colors.black12,
                                          highlightColor: Colors.black12,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          onPressed: () {
                                            widget.signOut();
                                          },
                                        );
                                      } else {
                                        return FlatButton(
                                          child: const Text(
                                            'Sign In',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Colors.blueAccent,
                                          splashColor:
                                              Colors.blueAccent.shade100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          onPressed: () {
                                            widget.signIn();
                                          },
                                        );
                                      }
                                    },
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
