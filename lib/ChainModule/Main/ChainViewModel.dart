

class ChainViewModel {
  static final ChainViewModel _singleton = ChainViewModel._internal();
  factory ChainViewModel() => _singleton;
  ChainViewModel._internal();
}