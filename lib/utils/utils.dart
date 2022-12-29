import 'package:flutter/material.dart';
import 'package:flutter_new/utils/timeline_util.dart';

import '../res/strings.dart';
class Utils {


  static Color nameToColor(String name) {
    // assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  static String getTimeLine(BuildContext context, int timeMillis) {
//    LogUtil.e("countryCode: " +
//        Localizations.localeOf(context).countryCode +
//        "   languageCode: " +
//        Localizations.localeOf(context).languageCode);
    return TimelineUtil.format(timeMillis,
        locale: Localizations.localeOf(context).languageCode,
        dayFormat: DayFormat.Common);
  }
  static String getPath({String path: '', int? page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }
  static bool isNeedLogin(String pageId) {
    if (pageId == Ids.titleCollection) {
      return true;
    }
    return true;
  }
}
