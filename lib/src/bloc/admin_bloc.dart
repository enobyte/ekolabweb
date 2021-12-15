import 'package:ekolabweb/src/model/rekap_user_model.dart';
import 'package:ekolabweb/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class AdminBloc {
  final _repository = Repository();
  final _rekapPenawaran = PublishSubject<RekapUserModel>();
  final _rekapResponse = PublishSubject<RekapUserModel>();
  final _rekapKatProduct = PublishSubject<RekapUserModel>();

  Stream<RekapUserModel> get rekapPenawaran => _rekapPenawaran.stream;

  Stream<RekapUserModel> get rekapResponse => _rekapResponse.stream;

  Stream<RekapUserModel> get rekapKatProduct => _rekapKatProduct.stream;

  fetchRekapPenawaran() async {
    RekapUserModel model = await _repository.getRekapPenawaran();
    if (model.status ?? false)
      _rekapPenawaran.sink.add(model);
    else
      _rekapPenawaran.sink.addError(model.message!);
  }

  fetchRekapResponse() async {
    RekapUserModel model = await _repository.getRekapResponse();
    if (model.status ?? false)
      _rekapResponse.sink.add(model);
    else
      _rekapResponse.sink.addError(model.message!);
  }

  fetchRekapKatProduct() async {
    RekapUserModel model = await _repository.getRekapKategoriProduct();
    if (model.status ?? false)
      _rekapKatProduct.sink.add(model);
    else
      _rekapKatProduct.sink.addError(model.message!);
  }

  dispose() {
    _rekapPenawaran.close();
    _rekapResponse.close();
    _rekapKatProduct.close();
  }
}

final bloc = AdminBloc();
