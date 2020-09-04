import 'package:etiquetador/User/repository/rest_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AppBloc implements Bloc {

  final _restApi = RestApi();


  Future<bool> updateLabel({String image, String label}) async {
    return await this._restApi.updateLabel(imageName: image, label: label);
  }

  @override
  void dispose() {

  }
}
