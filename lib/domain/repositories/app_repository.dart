
import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/app_error.dart';

abstract class AppRepository {

  Future<Either<AppError , void>> updateLanguage(String languageCode);
  Future<Either<AppError , String>> getPreferLanguage();
  Future<Either<AppError , void>> updateTheme(String theme);
  Future<Either<AppError , String>> getPreferTheme();

}