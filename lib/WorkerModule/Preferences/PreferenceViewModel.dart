

class PreferenceViewModel {
  static final PreferenceViewModel _singleton = PreferenceViewModel._internal();
  factory PreferenceViewModel(){return _singleton;}
  PreferenceViewModel._internal();

  int prefWeeklyShifts;
  int maxWeeklyShifts;

}