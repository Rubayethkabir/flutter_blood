import 'package:TenTwelveBlood/src/applications/classes/hospital/hospital_class.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:flutter/foundation.dart';

class HospitalList {
  final Pagination pagination;
  final List<HospitalClass> hospitalList;

  HospitalList({@required this.pagination,@required this.hospitalList}); 
}
