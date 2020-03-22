import 'package:coronefro/model/with_label.dart';
import 'package:flutter/material.dart';

class MultipleCombobox<T extends WithLabel> extends StatefulWidget {
  const MultipleCombobox({
    @required this.labelText,
    @required this.values,
    this.width,
    this.padding,
    this.titleDialog,
    this.initialValues,
    this.onValuesSelected,
  });

  final String labelText;
  final List<T> values;
  final double width;
  final EdgeInsets padding;
  final String titleDialog;
  final List<String> initialValues;
  final ValueChanged<List<T>> onValuesSelected;

  @override
  State<StatefulWidget> createState() => _MultipleComboboxState<T>();
}

class _MultipleComboboxState<T extends WithLabel>
    extends State<MultipleCombobox<T>> {
  List<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.initialValues ?? <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.width,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: InputDecorator(
          isEmpty: selectedValues.isEmpty,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),
            border: OutlineInputBorder(),
            labelText: widget.labelText,
          ),
          child: _buildChipsContainer(),
        ),
        onTap: () {
          _buildDialog(context);
        },
      ),
    );
  }

  Widget _buildChipsContainer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 43.0,
        child: Row(
          children: _buildChips(),
        ),
      ),
    );
  }

  List<Widget> _buildChips() {
    final List<Widget> chip = <Widget>[];

    for (String val in selectedValues) {
      chip.add(
        Container(
          height: 32.0,
          margin: const EdgeInsets.only(top: 4.0, right: 4.0),
          child: Chip(
            label: Text(val),
            onDeleted: () {
              setState(() {
                selectedValues.removeWhere((String value) => value == val);
              });
            },
          ),
        ),
      );
    }

    return chip;
  }

  void _buildDialog(BuildContext context) {
    final List<String> allValues =
        widget.values.map((WithLabel item) => item.label).toList();

    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600.0,
              maxHeight: 600.0,
            ),
            child: _DialogCombobox<T>(
              title: widget.titleDialog ?? widget.labelText,
              values: allValues,
              valuesList: widget.values,
              selectedValues: selectedValues,
              onValuesSelected: widget.onValuesSelected,
              onSelectedValuesListChanged: (List<String> values) {
                setState(() {
                  selectedValues = values;
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class _DialogCombobox<T extends WithLabel> extends StatefulWidget {
  const _DialogCombobox({
    this.title,
    this.values,
    this.valuesList,
    this.selectedValues,
    this.onValuesSelected,
    this.onSelectedValuesListChanged,
  });

  final String title;
  final List<String> values;
  final List<T> valuesList;
  final List<String> selectedValues;
  final ValueChanged<List<T>> onValuesSelected;
  final ValueChanged<List<String>> onSelectedValuesListChanged;

  @override
  _DialogComboboxState<T> createState() => _DialogComboboxState<T>();
}

class _DialogComboboxState<T extends WithLabel>
    extends State<_DialogCombobox<T>> {
  List<String> _tempSelectedValues = <String>[];
  TextEditingController controllerFieldFilter = TextEditingController();
  String filter;

  @override
  void initState() {
    _tempSelectedValues = widget.selectedValues;

    controllerFieldFilter.addListener(() {
      setState(() => filter = controllerFieldFilter.text);
    });

    super.initState();
  }

  @override
  void dispose() {
    controllerFieldFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          _buildTitle(),
          _buildFilterField(),
          _buildList(),
          _buildButtonBar(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFilterField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0.0),
          border: OutlineInputBorder(),
          hintText: 'Filtrar...',
          prefixIcon: Icon(Icons.search),
        ),
        controller: controllerFieldFilter,
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.grey,
          height: 1.0,
        ),
        itemCount: widget.values.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(context, index);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final String valueName = widget.values[index];
    Widget listItem = Container();

    if ((filter == null || filter == '') ||
        (widget.values[index].toLowerCase().contains(filter.toLowerCase()))) {
      listItem = CheckboxListTile(
        title: Text(valueName),
        value: _tempSelectedValues.contains(valueName),
        onChanged: (bool value) {
          if (value) {
            if (!_tempSelectedValues.contains(valueName)) {
              setState(() {
                _tempSelectedValues.add(valueName);
              });
            }
          } else {
            if (_tempSelectedValues.contains(valueName)) {
              setState(() {
                _tempSelectedValues
                    .removeWhere((String value) => value == valueName);
              });
            }
          }
          widget.onSelectedValuesListChanged(_tempSelectedValues);
        },
      );
    }

    return listItem;
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('FECHAR'),
          onPressed: () {
            if (widget.onValuesSelected != null) {
              final List<T> selectedList = _tempSelectedValues
                  .map((String label) =>
                      widget.valuesList.firstWhere((T v) => v.label == label))
                  .toList();
              widget.onValuesSelected(selectedList);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
