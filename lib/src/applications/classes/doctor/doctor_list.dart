import 'package:TenTwelveBlood/src/applications/classes/doctor/doctor_class.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:flutter/foundation.dart';

class DoctorList {
  final Pagination pagination;
  final List<DoctorClass> doctorList;

  DoctorList({@required this.pagination,@required this.doctorList}); 
}
