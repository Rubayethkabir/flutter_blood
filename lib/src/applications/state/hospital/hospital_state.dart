import 'package:TenTwelveBlood/src/applications/classes/hospital/hospital_class.dart';
import 'package:TenTwelveBlood/src/applications/classes/hospital/hospital_list.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/hospital_repository.dart';

class HospitalState {
  final HospitalRepository _hospitalReprository;
  HospitalState(this._hospitalReprository);

  List<HospitalClass> _hospitalList = [];
  List<HospitalClass> get hospitalList => _hospitalList;

  Pagination _pagination;
  
  bool _loading = false;
  bool get loading => _loading; 
  bool _fetchNext = true;
  
  Future getAllHospitalList() async {
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
      HospitalList _newHospitalList =
          await _hospitalReprository.getAllHospitalList(currentPage);
      _hospitalList.addAll(_newHospitalList.hospitalList);
      _pagination = _newHospitalList.pagination;
      _loading = false;
    }
  }
}