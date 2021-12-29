
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/data_sources/app_language_local_data_source.dart';
import 'package:movie_app/data/data_sources/app_theme_local_data_source.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository{
  final LanguageLocalDataSource languageLocalDataSource;
  final ThemeLocalDataSource themeLocalDataSource;

  AppRepositoryImpl(this.languageLocalDataSource , this.themeLocalDataSource);

  @override
  Future<Either<AppError, String>> getPreferLanguage()async {
    try{
      final response = await languageLocalDataSource.getPreferLanguage();
      return Right(response);
    }on Exception{
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String languageCode)async {
    try{
      final response = await languageLocalDataSource.updateLanguage(languageCode);
      return Right(response);
    }on Exception{
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, String>> getPreferTheme()async {
    try{
      final response = await themeLocalDataSource.getPreferTheme();
      return Right(response);
    }on Exception{
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateTheme(String theme)async {
    try{
      final response = await themeLocalDataSource.updateTheme(theme);
      return Right(response);
    }on Exception{
      return const Left(AppError(AppErrorType.database));
    }
  }

}