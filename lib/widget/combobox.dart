import 'package:coronefro/model/with_label.dart';
import 'package:flutter/material.dart';

class Combobox<T extends WithLabel> extends StatefulWidget {
  const Combobox({
    @required this.labelText,
    @required this.values,
    this.initialValue,
    this.streamedValue,
    this.width,
    this.padding,
    this.titleDialog,
    this.enabled = true,
    this.onValueSelected,
  });

  final String labelText;
  final List<T> values;
  final T initialValue;
  final Stream<T> streamedValue;
  final double width;
  final EdgeInsets padding;
  final String titleDialog;
  final bool enabled;
  final ValueChanged<T> onValueSelected;

  @override
  State<StatefulWidget> createState() => _ComboboxState<T>();
}

class _ComboboxState<T extends WithLabel> extends State<Combobox<T>> {
  T selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedValue = widget.initialValue;
    }
    if (widget.streamedValue != null) {
      widget.streamedValue.listen((T t) => setState(() => selectedValue = t));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.width,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: InputDecorator(
          isEmpty: selectedValue == null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),
            border: OutlineInputBorder(),
            labelText: widget.labelText,
            enabled: widget.enabled,
          ),
          child: _buildChipsContainer(),
        ),
        onTap: widget.enabled ? () => _buildDialog() : null,
      ),
    );
  }

  Widget _buildChipsContainer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 43.0,
        child: _buildChips(),
      ),
    );
  }

  Widget _buildChips() {
    return selectedValue != null
        ? Container(
            height: 32.0,
            margin: const EdgeInsets.only(top: 4.0, right: 4.0),
            child: Chip(
              label: Text(selectedValue.label ?? ''),
              onDeleted: widget.enabled
                  ? () {
                      widget.onValueSelected(null);
                      setState(() => selectedValue = null);
                    }
                  : null,
            ),
          )
        : Container();
  }

  void _buildDialog() {
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
              values: widget.values,
              selectedValues: selectedValue,
              onSelectedValuesListChanged: (T value) {
                if (widget.onValueSelected != null) {
                  widget.onValueSelected(value);
                }
                setState(() => selectedValue = value);
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
    this.selectedValues,
    this.onSelectedValuesListChanged,
  });

  final String title;
  final List<T> values;
  final T selectedValues;
  final ValueChanged<T> onSelectedValuesListChanged;

  @override
  _DialogComboboxState<T> createState() => _DialogComboboxState<T>();
}

class _DialogComboboxState<T extends WithLabel>
    extends State<_DialogCombobox<T>> {
  T _tempSelectedValues;
  TextEditingController controllerFieldFilter = TextEditingController();
  String filter;
  List<T> allValues;

  @override
  void initState() {
    _tempSelectedValues = widget.selectedValues;

    controllerFieldFilter.addListener(() {
      setState(() => filter = controllerFieldFilter.text);
    });

    allValues = widget.values;

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
        style: const TextStyle(
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
    final T value = allValues[index];
    final String valueName = value.label;
    Widget listItem = Container();

    if ((filter == null || filter == '') ||
        (valueName.toLowerCase().contains(filter.toLowerCase()))) {
      listItem = ListTile(
        title: Text(valueName),
        onTap: () {
          setState(() => _tempSelectedValues = value);
          widget.onSelectedValuesListChanged(getSelectedItem());
          Navigator.of(context).pop();
        },
      );
    }

    return listItem;
  }

  T getSelectedItem() {
    return _tempSelectedValues;
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('FECHAR'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
