
import 'package:yele/src/api/failure/failure.dart';

class ApiException implements Exception {
  Failure failure;

  ApiException(this.failure);
}
