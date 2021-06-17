import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  final _repository = Repository();
  final _getProduct = BehaviorSubject<ProductModel>();
  final _createProduct = PublishSubject<ProductModel>();
  final _submissionProduct = PublishSubject<ProductModel>();
  final _getSubmissionProduct = PublishSubject<ProductModel>();

  Stream<ProductModel> get getProduct => _getProduct.stream;

  Stream<ProductModel> get createProduct => _createProduct.stream;

  Stream<ProductModel> get submissionProduct => _submissionProduct.stream;
  Stream<ProductModel> get getSubmissionProduct => _getSubmissionProduct.stream;

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

  getSubmissionRequest(Map<String, dynamic> body) async {
    ProductModel model = await _repository.getSubmissionProduct(body);
    _getSubmissionProduct.sink.add(model);
  }

  dispose() {
    _getProduct.close();
    _createProduct.close();
    _submissionProduct.close();
    _getSubmissionProduct.close();
  }
}

final bloc = ProductBloc();
