
import 'package:flutter/material.dart';

class SearchBarField extends StatefulWidget {
  const SearchBarField({
    Key? key,
    required this.onSearchChanged,
    String? pleaseHolder,
  })  : pleaseHolder = pleaseHolder ?? 'Buscar',
        super(key: key);

  final String pleaseHolder;
  final ValueChanged<String>? onSearchChanged;

  @override
  _SearchBarFieldState createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<SearchBarField> {
  final TextEditingController _fieldText = TextEditingController();

  @override
  void dispose() {
    _fieldText.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (widget.onSearchChanged != null) {
      widget.onSearchChanged!(query);
    }
  }

  void _onClear() {
    _fieldText.clear();
    _onSearchChanged('');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _fieldText,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          labelText: widget.pleaseHolder,
          suffix: IconButton(
            onPressed: _onClear,
            icon: const Icon(Icons.clear),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}