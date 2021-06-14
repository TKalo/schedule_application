
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/CustomRX.dart';
import 'package:schedule_application_conn/ConnectionModule/WebSocketRequest.dart';
import 'package:schedule_application_entities/DataObjects/RequestProgress.dart';
import 'package:schedule_application_entities/DataObjects/WorkerCreationRequest.dart';

class WorkerRequestsViewModel {
  static final WorkerRequestsViewModel _singleton = WorkerRequestsViewModel._internal();
  factory WorkerRequestsViewModel(){return _singleton;}
  WorkerRequestsViewModel._internal();

  WorkerCreationRequest selectedRequest;
  RxValue<WorkerType> workerType = new RxValue(startWith: WorkerType.eighteen_plus);

  void addWorkerCreationRequest() async {
    print('addWorkerCreationRequest - viewmodel');
    MainViewModel().requestProgress.setData(RequestProgress.IN_PROGRESS);

    WorkerType type = await workerType.getData.first;
    print('addWorkerCreationRequest - viewmodel type');

    bool result = await WebSocketRequest().addWorkerCreationRequest(type);
    if(result){
      MainViewModel().requestProgress.setData(RequestProgress.ACCEPTED);
      MainViewModel().navigate();
    }else MainViewModel().requestProgress.setData(RequestProgress.DENIED);
  }

  void deleteWorkerCreationRequest(WorkerCreationRequest request) async {
    print("WorkerRequestsViewModel - deleteWorkerCreationRequest");
    WebSocketRequest().deleteWorkerCreationRequest(request.id);
  }

  void acceptWorkerCreationRequest(WorkerCreationRequest request) async {
    WebSocketRequest().acceptWorkerCreationRequest(request.id);
  }
}
