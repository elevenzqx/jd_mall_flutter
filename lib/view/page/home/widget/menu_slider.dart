// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/component/page_menu.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_state.dart';

Widget menuSlider(BuildContext context) {
  return StoreConnector<AppState, HomePageState>(
    converter: (store) {
      return store.state.homePageState;
    },
    builder: (context, state) {
      List<NineMenuList> nineMenuList = state.homePageInfo.nineMenuList ?? [];
      List<FunctionInfo> menuData = nineMenuList
          .map((e) => FunctionInfo(
                menuIcon: e.menuIcon,
                menuCode: e.menuCode,
                menuName: e.menuName,
                h5url: e.h5url,
              ))
          .toList();

      return SliverToBoxAdapter(
        child: PageMenu(
          menuDataList: menuData,
          rowCount: 2,
        ),
      );
    },
  );
}
