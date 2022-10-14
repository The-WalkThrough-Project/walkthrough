import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CampoFormHorario extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const CampoFormHorario(
      {Key? key, required this.label, required this.controller})
      : super(key: key);

  @override
  State<CampoFormHorario> createState() => _CampoFormHorarioState();
}

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class _CampoFormHorarioState extends State<CampoFormHorario> {
  
  String format(BuildContext context, TimeOfDay _timeOfDay) {
      assert(debugCheckHasMediaQuery(context));
      assert(debugCheckHasMaterialLocalizations(context));
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      return localizations.formatTimeOfDay(
        _timeOfDay,
        alwaysUse24HourFormat: MediaQuery.of(context).alwaysUse24HourFormat,
      );
    }

  TimeOfDay _timeOfDay = const TimeOfDay(hour: 7, minute: 0);

  void _showTimePicker() {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        }).then((value) {
      setState(() {
        _timeOfDay = value!;
        widget.controller.text = _timeOfDay.to24hours();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
            fontSize: 15,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 139, 108, 192),
                fontWeight: FontWeight.bold),
            suffixIcon: Container(
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.deepPurple))),
              child: IconButton(
                  onPressed: _showTimePicker,
                  icon: Icon(
                    Icons.timer,
                    color: Colors.deepPurple,
                  )),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.deepPurple)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.deepPurple))),
        readOnly: true,
      ),
    );
  }
}