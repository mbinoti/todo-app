import 'package:firebase_core/firebase_core.dart';

extension FirebaseExtension on Firebase {
  static Future<FirebaseApp> initializeAndConfigure() async {
    final FirebaseApp app = await Firebase.initializeApp();
    // Adicione aqui as configurações adicionais do Firebase, se necessário
    return app;
  }
}
