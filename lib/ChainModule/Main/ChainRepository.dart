

class ChainRepository{
  static final ChainRepository _singleton = ChainRepository._internal();
  factory ChainRepository(){return _singleton;}
  ChainRepository._internal();


}