
import 'package:TenTwelveBlood/src/applications/about_us/about_us_class.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:flutter/foundation.dart';

class AboutUsList {
  final Pagination pagination;
  final List<AboutUsClass> aboutUsList;

  AboutUsList({@required this.pagination,@required this.aboutUsList}); 
}
