import 'package:etiquetador/Etiquetador/models/label_model.dart';
import 'package:etiquetador/User/models/user.dart';
import 'package:etiquetador/User/repository/auth_repository.dart';
import 'package:etiquetador/User/repository/clour_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBloc implements Bloc {

  final  _auth_repository = AuthRepository();

  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;


  Stream<FirebaseUser> get authStatus => streamFirebase;

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<FirebaseUser> signIn() {
    return this._auth_repository.signInFirebase();
  }

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();


  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);
 
  void updateLabelData(LabelModel labelModel) => 
        _cloudFirestoreRepository.updateLabelFirestore(labelModel);

  signOut() {
    _auth_repository.signOut();
  }


  @override
  void dispose() {

  }
}
