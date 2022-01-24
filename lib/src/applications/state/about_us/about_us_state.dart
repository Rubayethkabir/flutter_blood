import 'package:TenTwelveBlood/src/applications/about_us/about_us_class.dart';
import 'package:TenTwelveBlood/src/applications/about_us/about_us_list.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/about_us_repository.dart';

class AboutUsState {
  final AboutUsRepository _aboutUsReprository;
  AboutUsState(this._aboutUsReprository);

  List<AboutUsClass> _aboutUsList = [];
  List<AboutUsClass> get aboutUsList => _aboutUsList;

  Pagination _pagination;
  
  bool _loading = false;
  bool get loading => _loading; 
  bool _fetchNext = true;
  int aboutType = 0;
  bool _fetchData = true;
  
  Future getAllAboutUsList(int type) async {
    if(type == this.aboutType) {
      _fetchData = false;
    }
    this.aboutType = type;

    int currentPage = 1;
    if (_pagination == null) {
      _fetchNext = true;
    } else if (_pagination != null && _pagination.currentPage < _pagination.lastPage) {
      currentPage = _pagination.currentPage + 1;
      _fetchNext = true;
    } else {
      _fetchNext = false;
    }

    if (_fetchData && _fetchNext) {
      _loading = true;
      AboutUsList _newAboutUsList =
          await _aboutUsReprository.getAllAboutUsList(type,currentPage);
        _aboutUsList.addAll(_newAboutUsList.aboutUsList); 
      _loading = false;
    }
  }

  //  setStateClear() {
  //   this._fetchNext = true;
  //   this._pagination = null;
  //   this._aboutUsList = [];
  // }

}