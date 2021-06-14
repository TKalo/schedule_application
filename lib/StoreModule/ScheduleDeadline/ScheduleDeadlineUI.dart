

import 'package:flutter/material.dart';
import 'package:schedule_application/StructureModule/support/CustomComponents.dart';
import 'package:schedule_application_entities/DataObjects/ScheduleTemplate.dart';
import 'ScheduleDeadlineViewModel.dart';

class ScheduleDeadlineUI extends StatefulWidget {
  @override
  _ScheduleDeadlineUIState createState() => _ScheduleDeadlineUIState();
}

class _ScheduleDeadlineUIState extends State<ScheduleDeadlineUI> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScheduleTemplate>(
      stream: ScheduleDeadlineViewModel().localDeadlines.getData,
      builder: (context, snapshot) {
        ScheduleTemplate template = snapshot.data ?? ScheduleTemplate();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text('schedule deadlines'),
                        content: Text('Set the deadlines for the upcoming schedule. Each deadline must be 3 days after the last deadline, and 3 days before the next deadline. The minimum allowed deadline is 3 days after current date.'),
                      );
                    });
              }, icon: Icon(Icons.help_outline_rounded)),
              Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomDatePicker(
                      title: 'preference deadline',
                      color: Colors.blue,
                      date: template.preferenceDeadline,
                      minDate: ScheduleDeadlineViewModel().prefMin,
                      maxDate: ScheduleDeadlineViewModel().prefMax,
                      onChanged: (string) => ScheduleDeadlineViewModel().localDeadlines.setData(template..preferenceDeadline = DateTime.parse(string)),
                      validator: (string) => ScheduleDeadlineViewModel().savedDeadlines.preferenceDeadline != null && !DateTime.parse(string).isAtSameMomentAs(ScheduleDeadlineViewModel().savedDeadlines.preferenceDeadline) ? 'value not saved' : null,
                      autoValidate: true,
                    ),
                    Divider(height: 16,),
                    CustomDatePicker(
                      title: 'creation deadline',
                      color: Colors.blue,
                      date: template.creationDeadline,
                      minDate: ScheduleDeadlineViewModel().creationMin,
                      maxDate: ScheduleDeadlineViewModel().creationMax,
                      onChanged: (string) => ScheduleDeadlineViewModel().localDeadlines.setData(template..creationDeadline = DateTime.parse(string)),
                      validator: (string) => ScheduleDeadlineViewModel().savedDeadlines.creationDeadline != null && !DateTime.parse(string).isAtSameMomentAs(ScheduleDeadlineViewModel().savedDeadlines.creationDeadline) ? 'value not saved' : null,
                      autoValidate: true,
                    ),
                    Divider(height: 16,),
                    CustomDatePicker(
                      title: 'initialization deadline',
                      color: Colors.blue,
                      date: template.initiationDeadline,
                      minDate: ScheduleDeadlineViewModel().initiationMin,
                      maxDate: ScheduleDeadlineViewModel().initiationMax,
                      onChanged: (string) => ScheduleDeadlineViewModel().localDeadlines.setData(template..initiationDeadline = DateTime.parse(string)),
                      validator: (string) => ScheduleDeadlineViewModel().savedDeadlines.initiationDeadline != null && !DateTime.parse(string).isAtSameMomentAs(ScheduleDeadlineViewModel().savedDeadlines.initiationDeadline) ? 'value not saved' : null,
                      autoValidate: true,
                    ),
                    Divider(height: 16,),
                    CustomDropDownButton(
                      title: 'week duration',
                      color: Colors.blue,
                      value: template.weeks,
                      items: [4,5,6,7,8,9,10,11,12].map<DropdownMenuItem<int>>((int) => DropdownMenuItem(value: int, child: Text(int.toString()))).toList(),
                      onChanged: (duration) => setState(() =>template.weeks = duration),
                      validator: (int) => ScheduleDeadlineViewModel().savedDeadlines.weeks != null && int != ScheduleDeadlineViewModel().savedDeadlines.weeks ? 'value not saved' : null,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  ],
                ),
              ),
              Divider(height: 32,),
              Center(
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextButton(
                        title: 'set deadlines'.toUpperCase(),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onClick: () async {
                          if(_formKey.currentState.validate()){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text("new deadlines"),
                                    content: Text(""),
                                    actions: [
                                      TextButton(
                                        child: Text("create", style: TextStyle(fontSize: 16),),
                                        onPressed: () {
                                          ScheduleDeadlineViewModel().setScheduleValues();
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                }
                            );
                          }},
                      )
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
