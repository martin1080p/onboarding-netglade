enum ErrorColumn {
  id(position: 0, name: 'errorId', label: 'ID'),
  timestamp(position: 1, name: 'timestamp', label: 'Timestamp'),
  data(position: 2, name: 'data', label: 'Data');

  const ErrorColumn({
    required this.position,
    required this.name,
    required this.label,
  });

  final int position;
  final String name;
  final String label;
}
