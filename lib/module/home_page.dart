import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'package:primajasa/controller/checklist.dart';
import 'package:primajasa/model/checklist.dart';
import 'package:primajasa/module/checklist_create_page.dart';
import 'package:primajasa/module/checklist_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  PagingController<int, Checklist> pagingController = PagingController(firstPageKey: 1);
  bool isDone = false;
  final Map<int, Checklist> _selectedItems = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (mounted) {
      pagingController.addPageRequestListener((pageKey) {
        fetchListCheckList(
          pagingController,
          pageKey,
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
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteAnimator(
              child: const ChecklistCreatePage(),
              routeAnimation: RouteAnimation.leftToRight,
            ),
          );
        },
        child: Container(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.1),
                blurRadius: 1.0,
              )
            ],
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.1,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Text(
                  'Todo List',
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
                    builderDelegate: PagedChildBuilderDelegate<Checklist>(
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
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteAnimator(
                                  child: ChecklistDetailPage(
                                    id: item.id,
                                    title: item.title,
                                  ),
                                  routeAnimation: RouteAnimation.leftToRight,
                                ),
                              );
                            },
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
                                  updateCheckList(item.id);
                                });
                              },
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deleteCheckList(item.id).then((value) {
                                  if (value == 200) {
                                    pagingController.refresh();
                                  }
                                });
                              },
                            ),
                            title: Text(
                              item.title,
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
