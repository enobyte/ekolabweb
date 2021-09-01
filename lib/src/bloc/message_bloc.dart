import 'package:ekolabweb/src/model/standard_map_model.dart';
import 'package:ekolabweb/src/model/standard_maplist_model.dart';
import 'package:ekolabweb/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class MessageBloc {
  final _repository = Repository();
  final _chatingBloc = PublishSubject<StandardMapListModels>();
  final _chatingListBloc = PublishSubject<StandardMapListModels>();
  final _saveChatingBloc = PublishSubject<bool>();

  Stream<StandardMapListModels> get chatingListBloc => _chatingListBloc.stream;

  Stream<StandardMapListModels> get chatingBloc => _chatingBloc.stream;

  Stream<bool> get saveChatingBloc => _saveChatingBloc.stream;

  fetchMessage(Map<String, dynamic> body) async {
    StandardMapListModels model = await _repository.getChating(body);
    if (model.status ?? false)
      _chatingBloc.sink.add(model);
    else
      _chatingBloc.sink.addError(model.message);
  }

  fetchMessageList(Map<String, dynamic> body) async {
    StandardMapListModels model = await _repository.getChatingList(body);
    if (model.status ?? false)
      _chatingListBloc.sink.add(model);
    else
      _chatingListBloc.sink.addError(model.message);
  }

  saveMessage(Map<String, dynamic> body) async {
    _saveChatingBloc.sink.add(true);
    StandardMapListModels model = await _repository.saveChating(body);
    if (model.status ?? false)
      _saveChatingBloc.sink.add(false);
    else
      _saveChatingBloc.sink.addError("Cannot Send Message");
  }

  getMessageSave(Map<String, dynamic> data) {
    _chatingBloc.sink.add(StandardMapListModels("OK", true, [data], 200));
  }

  dispose() {
    _chatingBloc.close();
    _saveChatingBloc.close();
    _chatingListBloc.close();
  }
}

final bloc = MessageBloc();
