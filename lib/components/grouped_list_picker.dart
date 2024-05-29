import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:restoe/components/adaptive_app_bar.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/config/theme/theme.dart';

class SelectType {
  final String uuid;
  final String name;

  const SelectType({required this.uuid, required this.name});
}

typedef ListFuture<T extends SelectType> = Future<List<T>> Function();

class GroupedListPicker<T extends SelectType> extends StatefulWidget {
  final List<T>? selected;
  final bool isMulti;
  final String name;
  final ListFuture<T> listFuture;
  final bool? automaticallyImplyLeading;

  const GroupedListPicker({
    super.key,
    required this.listFuture,
    this.selected,
    this.isMulti = false,
    this.name = 'Select',
    this.automaticallyImplyLeading = true,
  });

  @override
  State<GroupedListPicker<T>> createState() => _GroupedListPickerState<T>();
}

class _GroupedListPickerState<T extends SelectType> extends State<GroupedListPicker<T>> {
  List<T>? selected;

  Future<List<T>>? dataListFuture;
  List<T>? data;

  final _searchController = TextEditingController();

  @override
  initState() {
    super.initState();

    /// Hook up the search listener
    _searchController.addListener(_onQueryChanged);

    if (widget.isMulti) {
      selected = [];
    }
    if (widget.selected != null) {
      selected = widget.selected;
    }

    dataListFuture = widget.listFuture();
    _hydrateData();
  }

  _onQueryChanged() {
    setState(() {
      /// Trigger re-render because search query changed
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _hydrateData() async {
    final temp = await widget.listFuture();
    setState(() {
      data = temp;
    });
  }

  handleSelect(T element) {
    if (widget.isMulti) {
      setState(() {
        if (selected == null) {
          setState(() {
            selected = [element];
          });
        } else if (selected is List<T>) {
          final idx = selected!.indexWhere((i) => i.uuid == element.uuid);
          if (idx == -1) {
            selected!.add(element);
          } else {
            selected!.removeAt(idx);
          }
        }
      });
    } else {
      setState(() {
        selected = [element];
      });

      Navigator.pop<List<T>?>(context, [element]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selected != null && selected!.isNotEmpty) {
          Navigator.pop<List<T>?>(context, selected);
        } else {
          Navigator.pop(context);
        }

        return true;
      },
      child: AdaptivePageScaffold(
        automaticallyImplyLeading: widget.automaticallyImplyLeading ?? true,
        appBar: AdaptiveAppBar(
          title: Text(widget.name),
        ),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CupertinoSearchTextField(
            autofocus: true,
            controller: _searchController,
          ),
        ),
        Expanded(child: _getList())
      ],
    );
  }

  Widget _getList() {
    final query = _searchController.text;

    final filteredItems = query.isEmpty
        ? data ?? []
        : (data ?? [])
            .where(
              (e) => e.name.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
            )
            .toList();

    if (data == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text('No items found'),
      );
    }

    return GroupedListView<T, String>(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      elements: filteredItems,
      // Group by first letter
      groupBy: (element) => element.name[0],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) => item1.name.compareTo(item2.name),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: false,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: colors(context).onSurface.s400,
          ),
        ),
      ),

      itemBuilder: (c, element) {
        return Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(20, 0, 0, 0),
              width: 1,
            ),
          )),
          child: ListTile(
            trailing: (selected != null && selected!.any((el) => el.uuid == element.uuid))
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : null,
            onTap: () => handleSelect(element),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            title: Text(element.name),
          ),
        );
      },
    );
  }
}
