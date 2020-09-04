import 'package:etiquetador/Etiquetador/models/label_model.dart';
import 'package:etiquetador/User/models/user.dart';
import 'package:etiquetador/User/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);
  void updateLabelFirestore(LabelModel labelModel) => 
      _cloudFirestoreAPI.updateLabelData(labelModel);
}
