import 'package:TenTwelveBlood/src/applications/classes/blood/blood.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:flutter/foundation.dart';

class BloodList {
  final Pagination pagination;
  final List<Blood> bloodList;

  BloodList({@required this.pagination,@required this.bloodList}); 
}
