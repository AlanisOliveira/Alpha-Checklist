import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCUxk75sLNiWV9Y0Lp7ymqIEHmY52h80_U",
            authDomain: "alpha-checklist-fiy1cd.firebaseapp.com",
            projectId: "alpha-checklist-fiy1cd",
            storageBucket: "alpha-checklist-fiy1cd.appspot.com",
            messagingSenderId: "666673361201",
            appId: "1:666673361201:web:34f62fc19a80d307378010"));
  } else {
    await Firebase.initializeApp();
  }
}
