import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:primajasa/component/costum_button.dart';
import 'package:primajasa/component/costum_text_input.dart';
import 'package:primajasa/controller/item.dart';
import 'package:primajasa/model/item.dart';

class ChecklistDetailPage extends StatefulWidget {
  final int id;
  final String title;
  const ChecklistDetailPage({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  State<ChecklistDetailPage> createState() => _ChecklistDetailPageState();
}

class _ChecklistDetailPageState extends State<ChecklistDetailPage> with WidgetsBindingObserver {
  TextEditingController titleController = TextEditingController();
  PagingController<int, Item> pagingController = PagingController(firstPageKey: 1);
  bool isDone = false;
  final Map<int, Item> _selectedItems = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (mounted) {
      pagingController.addPageRequestListener((pageKey) {
        fetchListItemList(
          pagingController,
          pageKey,
          widget.id,
        );
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Center(
                child: Text(
                  'Create ${widget.title} Items',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            CostumTextInput(
              controller: titleController,
              hintText: "Item",
              keyboardType: TextInputType.text,
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015,
                left: MediaQuery.of(context).size.height * 0.275,
              ),
              child: ButtonInput(
                onPressed: () {
                  createItemList(titleController.text, widget.id).then((v) {
                    if (v == 200) {
                      pagingController.refresh();
                    }
                  });
                },
                text: 'Submit',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'List Item',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.025,
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(0, 0.1),
                    )
                  ],
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    pagingController.refresh();
                  },
                  child: PagedListView(
                    pagingController: pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Item>(
                      firstPageErrorIndicatorBuilder: (context) {
                        return const Center(
                          child: Text('error'),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) {
                        return const Center(
                          child: Text('No Data'),
                        );
                      },
                      itemBuilder: (context, item, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.02,
                            vertical: MediaQuery.of(context).size.height * 0.01,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1,
                                offset: Offset(0, 0.1),
                              )
                            ],
                            color: Colors.white,
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Checkbox(
                              value: _selectedItems.containsKey(item.id)
                                  ? _selectedItems[item.id]!.done
                                  : item.done,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItems[item.id] = item.copyWith(
                                    done: value ?? false,
                                    updatedAt: DateTime.now(),
                                  );
                                  updateItem(item.id, widget.id).then((v) {
                                    if (v == 200) {
                                      pagingController.refresh();
                                    }
                                  });
                                });
                              },
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deleteItemList(item.id, widget.id).then((value) {
                                  if (value == 200) {
                                    pagingController.refresh();
                                  }
                                });
                              },
                            ),
                            title: Text(
                              item.item,
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
