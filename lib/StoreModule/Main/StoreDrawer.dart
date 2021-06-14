

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schedule_application/StoreModule/UserRequests/WorkerRequestsUI.dart';
import 'package:schedule_application/StructureModule/MainViewModel.dart';

class StoreDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: min(MediaQuery.of(context).size.width*0.9, 400),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: DrawerList()),
            DrawerToolbar()
          ],
        ),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: Icon(Icons.person_add_alt_1_rounded),
          title: Text('user requests'),
          onTap: () => MainViewModel().navigate(location: WorkerRequestsUI()),
        )
      ],
    );
  }
}

class DrawerToolbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: IconButton(
              color: Colors.grey[600],
              icon: Icon(Icons.lock_rounded),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            child: Text('logut', style: TextStyle(fontSize: 16),),
                            onPressed: () {
                              MainViewModel().logout();
                              MainViewModel().navigate(location: WorkerRequestsUI());
                            },
                          ),
                          TextButton(
                            child: Text('cancel', style: TextStyle(fontSize: 16),),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    }
                );
              },
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: IconButton(
              color: Colors.grey[600],
              icon: Icon(Icons.settings_rounded),
              onPressed: (){},
            ),
          ),
        ],
      ),
    );
  }
}


