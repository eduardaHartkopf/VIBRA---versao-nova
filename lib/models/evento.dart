import 'package:flutter/material.dart';

class Evento {
  final int? id;
  final String nome;
  final String imagem;
  final String descricao;
  final String data;
  final String horario;
  final String local;

  Evento({
    this.id,
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.data,
    required this.horario,
    required this.local,
  });

  factory Evento.fromMap(Map<String, dynamic> map) {
    return Evento(
      id: map['id'],
      nome: map['nome'],
      imagem: map['imagem'],
      descricao: map['descricao'],
      data: map['data'],
      horario: map['horario'],
      local: map['local'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'imagem': imagem,
      'descricao': descricao,
      'data': data,
      'horario': horario,
      'local': local,
    };
  }
}