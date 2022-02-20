import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

Future<Widget> openFirebaseDemoMethod() async {
  return const FirebaseDemoApp();
}

class FirebaseDemoApp extends StatefulWidget {
  const FirebaseDemoApp({Key? key}) : super(key: key);

  @override
  State<FirebaseDemoApp> createState() => _FirebaseDemoAppState();
}

class _FirebaseDemoAppState extends State<FirebaseDemoApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseInit();
    Future.delayed(const Duration(seconds: 5));
  }

  void firebaseInit() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
    } catch (e, st) {
      print(e);
      print(st);
    }

    // The first step to using Firebase is to configure it so that
    // our code can find the Firebase project on the servers. This
    // is not a security risk, as explained here: https://stackoverflow.com/a/37484053
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAhE5iTdU1MflQxb4_M_uHiXJR9EC_mE_I",
            authDomain: "nanochat.firebaseapp.com",
            projectId: "firebase-nanochat",
            messagingSenderId: '137230848633',
            appId: '1:137230848633:web:89e9b54f881fa0b843baa8'));

    // We sign the user in anonymously, meaning they get a user ID
    // without having to provide credentials. While this doesn't
    // allow us to identify the user, this would still allow us to
    // for example associate data in the database with each user.
    await FirebaseAuth.instance.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // We use a stream builder to both read the initial data from the database and
        // listen to updates to that data in realtime. The database we use is called
        // Firestore, and we are asking the 10 most recent messages.
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('timestamp', descending: true)
              .limit(10)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('$snapshot.error'));
            } else if (!snapshot.hasData) {
              return const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            var docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) {
                  // The user can send a message to Firebase. What they can send is
                  // protected by server-side security rules, which in this case only
                  // allow chat messages that this regular expression:
                  //    ^((?i)hello|\\s|firebase|welcome|to|summit|the|this||everyone|good|morning|afternoon|firestore|meetup|devfest|virtual|online)+
                  // In a real project you'd probably expand that, for example by only allowing users
                  // that you explicitly approve to post messages.
                  return TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your message and hit Enter'),
                    onSubmitted: (String value) {
                      FirebaseFirestore.instance.collection('chat').add(
                        {
                          'message': value,
                          'timestamp': DateTime.now().millisecondsSinceEpoch
                        },
                      );
                    },
                  );
                } else {
                  return ListTile(
                    leading: Text('${docs[i - 1]['timestamp']}'),
                    title: Text('${docs[i - 1]['message']}'),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
