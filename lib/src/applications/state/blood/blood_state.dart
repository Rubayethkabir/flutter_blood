import 'package:TenTwelveBlood/src/applications/classes/blood/blood.dart';
import 'package:TenTwelveBlood/src/applications/classes/blood/blood_list.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/blood_repository.dart';

class BloodState {
  final BloodRepository _bloodReprository;
  BloodState(this._bloodReprository);

  List<Blood> _bloodList = [];
  List<Blood> get bloodList => _bloodList;

  Pagination _pagination;
  
  bool _loading = false;
  bool get loading => _loading; 
  bool _fetchNext = true;
  String groupName;

  String searchValue;
  bool isSearching = false;
  
  Future getAllBloodList(groupName, searchValue) async {
    if(this.groupName != groupName){
      this._bloodList = [];
      this.groupName = groupName;
      _pagination = null;
    }
    
    if(this.searchValue != searchValue){
      this._bloodList = [];
      this.searchValue = searchValue;
      _pagination = null;
    }
    
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
      BloodList _newBloodList =
          await _bloodReprository.getAllBloodList(groupName,currentPage,searchValue);
      _bloodList.addAll(_newBloodList.bloodList);
      _pagination = _newBloodList.pagination;
      _loading = false;
    }
  }

  setStateClear() {
    this._fetchNext = true;
    this._pagination = null;
    this._bloodList = [];

  }

  setSearching(bool setValue){
    this.isSearching = setValue;
  }
  
}