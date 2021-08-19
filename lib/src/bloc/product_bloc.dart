import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/submission_model.dart';
import 'package:ekolabweb/src/model/submisson_proc_model.dart';
import 'package:ekolabweb/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  final _repository = Repository();
  final _getProduct = BehaviorSubject<ProductModel>();
  final _createProduct = PublishSubject<ProductModel>();
  final _submissionProduct = PublishSubject<ProductModel>();
  final _submissionProc = PublishSubject<ProductModel>();
  final _getSubmissionProduct = BehaviorSubject<SubmissionModel>();
  final _getSubmissionProcess = BehaviorSubject<SubmissionProcModel>();

  Stream<ProductModel> get getProduct => _getProduct.stream;

  Stream<ProductModel> get createProduct => _createProduct.stream;

  Stream<ProductModel> get submissionProduct => _submissionProduct.stream;

  Stream<ProductModel> get submissionProc => _submissionProc.stream;

  Stream<SubmissionModel> get getSubmissionProduct =>
      _getSubmissionProduct.stream;

  Stream<SubmissionProcModel> get getSubmissionProcess =>
      _getSubmissionProcess.stream;

  getProductList(Map<String, dynamic> body) async {
    ProductModel model = await _repository.getProduct(body);
    _getProduct.sink.add(model);
  }

  createProductList(Map<String, dynamic> body) async {
    ProductModel model = await _repository.createProduct(body);
    if (model.status!) {
      getProductList(body);
    }
    _createProduct.sink.add(model);
  }

  submissionRequest(Map<String, dynamic> body) async {
    ProductModel model = await _repository.submissionProduct(body);
    _submissionProduct.sink.add(model);
  }

  submissionProcess(Map<String, dynamic> body) async {
    ProductModel model = await _repository.submissionProc(body);
    _submissionProc.sink.add(model);
  }

  getSubmissionRequest(Map<String, dynamic> body) async {
    SubmissionModel model = await _repository.getSubmissionProduct(body);
    _getSubmissionProduct.sink.add(model);
  }

  getSubmissionProc(Map<String, dynamic> body) async {
    SubmissionProcModel model = await _repository.getSubmissionProcess(body);
    _getSubmissionProcess.sink.add(model);
  }

  dispose() {
    _getProduct.close();
    _createProduct.close();
    _submissionProduct.close();
    _getSubmissionProduct.close();
    _submissionProc.close();
    _getSubmissionProcess.close();
  }
}

final bloc = ProductBloc();
