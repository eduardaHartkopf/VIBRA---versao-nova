import 'package:flutter/material.dart';

import '../models/evento.dart';

const corDadosEvento = Color(0xFFB794F6);

List<(IconData, String)> dadosEvento(Evento evento) => [
  (Icons.calendar_month_outlined, evento.data),
  (Icons.schedule, evento.horario),
  (Icons.location_on_outlined, evento.local),
];
