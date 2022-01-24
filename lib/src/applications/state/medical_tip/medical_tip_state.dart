import 'package:TenTwelveBlood/src/applications/classes/medical_tip/medical_tip_list.dart';
import 'package:TenTwelveBlood/src/applications/classes/medical_tip/medical_tip_model.dart';
import 'package:TenTwelveBlood/src/applications/common/pagination.dart';
import 'package:TenTwelveBlood/src/repository/medical_tip_repository.dart';

class MedicalTipState {
  final MedicalTipRepository _medicalTipRepository;
  MedicalTipState(this._medicalTipRepository);

  Pagination _pagination;

  bool _loading = false;
  bool get loading => _loading;

  List<MedicalTipModel> _medicalTipList = [];
  List<MedicalTipModel> get medicalTipList => _medicalTipList;

  void getAllMedicalTip() async {
    int currentPage = 1;
    bool _fetchNext = false;

    if(_pagination == null) {
      _fetchNext = true;
    }else if(_pagination != null && _pagination.currentPage < _pagination.lastPage) {
      currentPage = _pagination.currentPage + 1;
      _fetchNext = true;
    }else {
      _fetchNext = false;
    }
    if(_fetchNext) {
      _loading = true;
      MedicalTipList medicalTipList = await _medicalTipRepository.getAllMedicalTip(currentPage);
      _medicalTipList.addAll(medicalTipList.medicalTipList);
      _pagination = medicalTipList.pagination;
      _loading = false;
    }
  }
}