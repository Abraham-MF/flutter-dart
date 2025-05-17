import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key, required this.title});
  final String title;

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Appointment> _appointments = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _obtenerDatos();
  }

  void _obtenerDatos() async {
    try {
      QuerySnapshot eventos = await db.collection("eventos").get();
      for (DocumentSnapshot evento in eventos.docs) {
        setState(() {
          final data = evento.data() as Map<String, dynamic>;
          // Convertir las fechas de Firestore a DateTime
          DateTime startTime = (data['hora_inicio'] as Timestamp).toDate();
          DateTime endTime = (data['hora_fin'] as Timestamp).toDate();

          Appointment appointment = Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: data['titulo'] ?? 'Sin título',
            color: Colors.blue,  // Puedes personalizar el color
          );

          _appointments.add(appointment);
        });
      }
    } catch (error) {
      print("Error al obtener los eventos: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          SfCalendar(
            view: CalendarView.month,
            initialSelectedDate: DateTime.now(),
            dataSource: AppointmentDataSource(_appointments),
            onTap: (CalendarTapDetails details) async {
              if (details.date != null && details.targetElement == CalendarElement.calendarCell) {
                final selectedDay = details.date!;
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(
                      selectedDay: selectedDay,
                    ),
                  ),
                );

                if (result is Appointment) {
                  setState(() {
                    _appointments.add(result);
                  });
                }
              } else if (details.targetElement == CalendarElement.appointment) {
                if (details.appointments != null && details.appointments!.isNotEmpty) {
                  Appointment appointment = details.appointments!.first;
                  setState(() {
                    _appointments.remove(appointment);
                  });
                }
              }

              if (details.date != null) {
                setState(() {
                  _selectedDate = details.date;
                });
              }
            },
            monthViewSettings: const MonthViewSettings(
              showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            ),
          ),
          if (_selectedDate != null) Expanded(child: _buildAgenda()),
        ],
      ),
    );
  }

  Widget _buildAgenda() {
    final selectedEvents = _appointments.where((event) =>
    event.startTime.year == _selectedDate!.year &&
        event.startTime.month == _selectedDate!.month &&
        event.startTime.day == _selectedDate!.day
    ).toList();

    if (selectedEvents.isEmpty) {
      return const Center(child: Text('No hay eventos'));
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final event = selectedEvents[index];
        return ListTile(
          leading: CircleAvatar(backgroundColor: event.color),
          title: Text(event.subject),
          subtitle: Text('${event.startTime.hour.toString().padLeft(2, '0')}:${event.startTime.minute.toString().padLeft(2, '0')} - '
              '${event.endTime.hour.toString().padLeft(2, '0')}:${event.endTime.minute.toString().padLeft(2, '0')}'),
        );
      },
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class EventDetailsPage extends StatefulWidget {
  final DateTime selectedDay;

  const EventDetailsPage({
    super.key,
    required this.selectedDay,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Color _selectedColor = Colors.blue;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles del Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Fecha seleccionada: ${widget.selectedDay.toLocal()}'),
            const SizedBox(height: 20),
            const Text('Selecciona un color para esta fecha:'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.orange,
                Colors.purple,
                Colors.teal,
              ].map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColor == color ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _selectTime(context, true),
                  child: Text('Hora inicio: ${_startTime.format(context)}'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectTime(context, false),
                  child: Text('Hora fin: ${_endTime.format(context)}'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final startDateTime = DateTime(
                  widget.selectedDay.year,
                  widget.selectedDay.month,
                  widget.selectedDay.day,
                  _startTime.hour,
                  _startTime.minute,
                );
                final endDateTime = DateTime(
                  widget.selectedDay.year,
                  widget.selectedDay.month,
                  widget.selectedDay.day,
                  _endTime.hour,
                  _endTime.minute,
                );

                final appointment = Appointment(
                  startTime: startDateTime,
                  endTime: endDateTime,
                  subject: 'Evento',
                  color: _selectedColor,
                );

                Navigator.pop(context, appointment);  // Devuelve el evento al calendario
              },
              child: const Text('Guardar Evento'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }
}
