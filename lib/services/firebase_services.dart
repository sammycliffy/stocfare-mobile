import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseOptions app = FirebaseOptions(
  googleAppID: "1:196605610944:android:3f4b5d32195c9094b55625",
  apiKey: '"AIzaSyDDREdmV0Qy2kUS-q8Q_NkeWealFYqO4zU"',
  databaseURL: '"https://stockfare-mobile.firebaseio.com"',
);


final FirebaseDatabase database = FirebaseDatabase(app:app)