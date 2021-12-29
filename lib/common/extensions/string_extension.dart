
import 'package:movie_app/presentation/app_localization.dart';

extension StringExtension on String{
  String intelliTrim(){
   return length  > 15 ? "${substring(0 , 15)}...": this;
  }
  String tr(context){
   return AppLocalization.of(context)!.translate(this)!;
  }
}