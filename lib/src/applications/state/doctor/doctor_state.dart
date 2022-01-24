import 'package:TenTwelveBlood/src/applications/classes/doctor/doctor_class.dart';
import 'package:TenTwelveBlood/src/applications/classes/doctor/doctor_list.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/doctor_repository.dart';

class DoctorState {
  final DoctorRepository _doctorReprository;
  DoctorState(this._doctorReprository);

  List<DoctorClass> _doctorList = [];
  List<DoctorClass> get doctorList => _doctorList;

  Pagination _pagination;
  
  bool _loading = false;
  bool get loading => _loading; 
  bool _fetchNext = true;
  
  Future getAllDoctorList() async {
    int currentPage = 1;
    if (_pagination == null) {
      _fetchNext = true;
    } else if (_pagination != null && _pagination.currentPage < _pagination.lastPage) {
      currentPage = _pagination.currentPage + 1;
      _fetchNext = true;
    } else {
      _fetchNext = false;
    }

    if (_fetchNext) {
      _loading = true;
      DoctorList _newdoctorList =
          await _doctorReprository.getAllDoctorList(currentPage);
      _doctorList.addAll(_newdoctorList.doctorList);
      _pagination = _newdoctorList.pagination;
      _loading = false;
    }
  }
}