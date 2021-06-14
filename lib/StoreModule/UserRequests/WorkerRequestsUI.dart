

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_application/StoreModule/Main/StoreRepository.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application_entities/DataObjects/WorkerCreationRequest.dart';

import 'WorkerCreationUI.dart';
import 'WorkerRequestsViewModel.dart';

class WorkerRequestsUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {MainViewModel().navigate();},),
        centerTitle: true,
        title: CustomTitleText(title: 'user requests', fontSize: 24,),
      ),
      body: Column(
          children: [
            Container(
              height: 64,
              color: Colors.blue[300],
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      AspectRatio(
                        aspectRatio: 1,
                        child: IconButton(
                          splashRadius: 28,
                          splashColor: Colors.white.withOpacity(0.5),
                          icon: Icon(Icons.person_add, color: Colors.white,),
                          onPressed: () => MainViewModel().navigate(location: WorkerCreationUI()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: StreamBuilder<Map<int, WorkerCreationRequest>>(
                stream: StoreRepository().userCreationRequests.getData,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Container(color: Colors.red,);
                  Map<int, WorkerCreationRequest> requests = snapshot.data;
                  return ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      WorkerCreationRequest request = requests.values.elementAt(index);
                      return ListTile(
                        leading: CircleAvatar(backgroundColor: request.status == WorkerCreationStatus.pending ? Colors.orange : Colors.green),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'workertype: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: request.type == WorkerType.eighteen_plus ? 'adult worker' : 'young worker')
                            ]
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: request.status == WorkerCreationStatus.pending ? 'pending chain administration acceptance' : 'accepted')
                              ]
                          ),
                        ),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {WorkerRequestsViewModel().deleteWorkerCreationRequest(request); Navigator.of(context).pop();},
                                        child: Text('delete')
                                    ),
                                    request.status == WorkerCreationStatus.pending ?
                                    TextButton(
                                        onPressed: (){WorkerRequestsViewModel().acceptWorkerCreationRequest(request); Navigator.of(context).pop();},
                                        child: Text('accept')
                                    ) : TextButton(
                                        onPressed: (){Clipboard.setData(new ClipboardData(text: request.key));Navigator.of(context).pop();},
                                        child: Text('copy key'))
                                  ],
                                );
                              }
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ]
      ),
    );
  }
}