import 'package:fpdart/fpdart.dart';
import 'package:parttime/core/error/app_failure.dart';

abstract interface class UseCase<Successtype, Params> {
  Future<Either<AppFailure, Successtype>> call(Params params);
}
