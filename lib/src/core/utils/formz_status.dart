import 'package:yele/src/core/utils/enums.dart';

extension FormzStatusExtension on FormzStatus {
  bool get isPure => this == FormzStatus.pure;
  bool get isLoading => this == FormzStatus.loading;
  bool get isSuccess => this == FormzStatus.success;
  bool get isFailed => this == FormzStatus.failed;
}
