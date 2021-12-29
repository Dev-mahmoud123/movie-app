
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';

abstract class UseCase<Type , Params>{
  /// Type => What does the UseCase return [OutPut]
  /// Params => What is required to call API [Input]

  Future<Either<AppError , Type>> call (Params params);

}