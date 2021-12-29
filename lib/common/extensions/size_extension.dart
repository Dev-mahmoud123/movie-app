


import 'package:movie_app/common/screen_utils/screen_utils.dart';

extension SizeExtension on double {

  double get w => ScreenUtil().setWidth(this);
  double get h => ScreenUtil().setHeight(this);
  double get sp => ScreenUtil().setSp(this);

}