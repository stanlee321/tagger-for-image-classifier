
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etiquetador/Etiquetador/models/label_model.dart';
import 'package:etiquetador/User/models/user.dart';
import 'package:uuid/uuid.dart';

class CloudFirestoreAPI {

  final String _users = "users";
  final String _labels = "labels";
  final Firestore _db = Firestore.instance;

  var uuid = new Uuid();

  void updateUserData(User user) async{
    DocumentReference ref = _db.collection(_users).document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'lastSignIn': DateTime.now()

    }, merge: true);
  }

  void updateLabelData(LabelModel labelModel) async{
    DocumentReference ref = _db.collection(_labels).document(labelModel.email);
    return await ref.setData(
      {
         uuid.v1(): {
          'email': labelModel.email,
          'timestamp': DateTime.parse(labelModel.timestamp),
          'imagePath': labelModel.imagePath,
          "label": labelModel.label

        }
      }
      , merge: true);
  }

}
