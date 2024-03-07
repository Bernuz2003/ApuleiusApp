class Spesa {
  final int? id;
  final String? articolo;
  final String? fornitore;
  final String? timestamp;
  final String? termine;
  final String? n_lista;
  final int? selezione;

  Spesa({
    required this.id, 
    this.articolo, 
    this.fornitore, 
    this.timestamp, 
    this.termine, 
    this.n_lista, 
    this.selezione
  });

  factory Spesa.fromMap(Map<String, dynamic> map) => new Spesa(
    id: map['id'],
    articolo: map['articolo'],
    fornitore: map['fornitore'],
    timestamp: map['timestamp'],
    termine: map['termine'],
    n_lista: map['n_lista'],
    selezione: map['selezione'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'articolo': articolo,
      'fornitore': fornitore,
      'timestamp': timestamp,
      'termine': termine,
      'n_lista': n_lista,
      'selezione': selezione,
    };
  }
}