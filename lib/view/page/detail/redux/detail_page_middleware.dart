// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_action.dart';
import 'package:jd_mall_flutter/view/page/detail/service.dart';

Future initData = Future.wait([DetailApi.queryDetailInfo(), DetailApi.queryStoreGoodsListByPage(1, pageSize)]);

class DetailPageMiddleware<MinePageState> implements MiddlewareClass<MinePageState> {
  @override
  call(Store<MinePageState> store, action, NextDispatcher next) {
    if (action is InitPageAction) {
      store.dispatch(SetLoadingAction(true));
      initData.then(
        (res) => {
          if (res[0] != null && res[0].bannerList.length > 0 && res[1] != null)
            {
              store.dispatch(SetLoadingAction(false)),
              store.dispatch(InitCurrentGoodsInfoAction(res[0], res[0].bannerList[0])),
              store.dispatch(InitGoodsPageAction(1, res[1]))
            }
        },
      );
    }
    if (action is LoadMoreAction) {
      DetailApi.queryStoreGoodsListByPage(action.currentPage, pageSize).then(
        (res) {
          var totalPage = res.totalPageCount;
          if (totalPage >= action.currentPage) {
            store.dispatch(MoreGoodsPageAction(action.currentPage, res));
            action.loadMoreSuccess();
          } else {
            action.loadMoreFail();
          }
        },
      );
    }
    next(action);
  }
}
