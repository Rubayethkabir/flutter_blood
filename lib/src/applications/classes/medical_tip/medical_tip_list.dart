import 'package:TenTwelveBlood/src/applications/classes/medical_tip/medical_tip_model.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:flutter/foundation.dart';

class MedicalTipList {

  final Pagination pagination;
  final List<MedicalTipModel> medicalTipList;
  MedicalTipList({@required this.pagination,@required this.medicalTipList});
}