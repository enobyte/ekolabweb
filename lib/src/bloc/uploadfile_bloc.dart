import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class UploadFileBloc {
  final _repository = Repository();
  final generalUploadFile = PublishSubject<FileModel>();

  Future<FileModel> fetchPostGeneralFile(FormData formData) async {
    FileModel model = await _repository.actUploadFile(formData);
    return model;
  }

  dispose() {
    generalUploadFile.close();
  }
}

final bloc = UploadFileBloc();
