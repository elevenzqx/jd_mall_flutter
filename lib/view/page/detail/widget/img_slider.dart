// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/photo_gallery/photo_gallery_dialog.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_state.dart';

Widget imgSlider(BuildContext context) {
  double statusHeight = getStatusHeight(context);
  double imgHeight = getScreenHeight(context) / 2 - statusHeight - getBottomSpace(context);
  double screenWidth = getScreenWidth(context);

  return StoreConnector<AppState, DetailPageState>(
    converter: (store) {
      return store.state.detailPageState;
    },
    builder: (context, state) {
      List<String> imgList = state.selectInfo.imgList ?? [];

      return Container(
        height: imgHeight,
        width: getScreenWidth(context),
        margin: EdgeInsets.only(top: statusHeight),
        child: FlutterCarousel(
          options: CarouselOptions(
            height: imgHeight,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 12),
            slideIndicator: CircularWaveSlideIndicator(
              itemSpacing: 14,
              indicatorRadius: 4,
              indicatorBorderWidth: 0,
              currentIndicatorColor: CommonStyle.themeColor,
              indicatorBackgroundColor: Colors.grey,
            ),
          ),
          items: imgList
              .map((url) => GestureDetector(
                    onTap: () => openPhotoGalleryDialog(context, imgList, imgList.lastIndexWhere((v) => v == url)),
                    child: CachedNetworkImage(
                      height: imgHeight,
                      width: screenWidth,
                      imageUrl: url,
                      placeholder: (context, url) => assetImage("images/default.png", screenWidth, imgHeight),
                      errorWidget: (context, url, error) => assetImage("images/default.png", screenWidth, imgHeight),
                      fit: BoxFit.fill,
                    ),
                  ))
              .toList(),
        ),
      );
    },
  );
}
