import 'package:firebase_core/firebase_core.dart';

// A extensão firebaseExtension adiciona um método estático chamado
//"initializeAndConfigure" à classe Firebase. Esse método retorna um
//Future de FirebaseApp.

// O método "initializeApp" é chamado internamente e retorna uma instância
// de FirebaseApp. Essa instância é, então, salva em uma variável "app".

// Se houver quaisquer outras configurações que precisam ser adicionadas ao
// Firebase, elas devem ser colocadas no comentário indicado e implementadas aqui.

// Finalmente, a instância do FirebaseApp é retornada pelo método
// "initializeAndConfigure".

// exemplo de uso
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeAndConfigure();
//   runApp(MyApp());
// }
//

extension FirebaseExtension on Firebase {
  static Future<FirebaseApp> initializeAndConfigure() async {
    final FirebaseApp app = await Firebase.initializeApp();
    // Adicione aqui as configurações adicionais do Firebase, se necessário
    return app;
  }
}
