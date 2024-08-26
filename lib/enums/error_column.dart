enum ErrorColumn {
  id(position: 0, name: 'errorId', label: 'ID'),
  timestamp(position: 1, name: 'timestamp', label: 'Timestamp'),
  dataBytes(position: 2, name: 'dataRaw', label: 'Data (bytes)'),
  dataString(position: 2, name: 'dataString', label: 'Data (string)');

  const ErrorColumn({
    required this.position,
    required this.name,
    required this.label,
  });

  final int position;
  final String name;
  final String label;
}
