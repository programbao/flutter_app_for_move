import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double width;
  final double height;
  final Widget? placeholder;
  final Widget errorWidget;
  final String errorImagePath;

  const CustomImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
    this.placeholder,
    this.errorWidget = const SizedBox.shrink(),
    this.errorImagePath = 'assets/error_image.png',
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          placeholder ??
          Container(
            color: Colors.grey[200],
            child: Center(
              child: Text(
                '加载中...',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
      errorWidget: (context, url, error) => Image.asset(
        errorImagePath,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}








// =========== 这是第一版封装的CustomImage ======
// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class CustomImage extends StatefulWidget {
//   final String url;
//   final double width;
//   final double height;
//   final String errorImagePath;
//   final BoxFit fit;

//   const CustomImage({
//     required this.url,
//     this.width = 0.0,
//     this.height = 0.0,
//     this.errorImagePath = 'assets/img/loading-fail.png',
//     this.fit = BoxFit.cover,
//   });

//   @override
//   _CustomImageState createState() => _CustomImageState();
// }

// class _CustomImageState extends State<CustomImage> {
//   ImageProvider? _imageProvider;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       // 在构建阶段完成后执行
//       _loadImage();
//     });
//     // _loadImage();
//   }

//   // @override
//   // void didUpdateWidget(CustomImage oldWidget) {
//   //   super.didUpdateWidget(oldWidget);
//   //   if (widget.url != oldWidget.url) {
//   //     _loadImage();
//   //   }
//   // }

//   Future<void> _loadImage() async {
//     try {
//       final networkImage = NetworkImage(widget.url);
//       // await networkImage.evict(); // 清除缓存以避免错误的图像显示
//       final imageConfig = createLocalImageConfiguration(context);
//       final imageStreamCompleter = networkImage.resolve(imageConfig);
//       final listener = ImageStreamListener(
//         (ImageInfo imageInfo, bool synchronousCall) {
//           setState(() {
//             _imageProvider = networkImage;
//           });
//         },
//         onError: (dynamic error, StackTrace? stackTrace, {String? context}) {
//           debugPrint('Failed to load image from URL: ${widget.url}');
//           setState(() {
//             _imageProvider = AssetImage(widget.errorImagePath);
//           });
//         },
//       );

//       imageStreamCompleter.addListener(listener);
//     } catch (error) {
//       debugPrint('Failed to load image from URL: ${widget.url}');
//       setState(() {
//         _imageProvider = AssetImage(widget.errorImagePath);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _imageProvider != null
//         ? CachedNetworkImage(
//             imageUrl: widget.url,
//             imageBuilder: (context, imageProvider) => Image(
//               image: imageProvider,
//               width: widget.width,
//               height: widget.height,
//               fit: widget.fit,
//             ),
//             placeholder: (context, url) => Container(
//               color: Colors.grey[200],
//               child: Center(
//                 child: Text(
//                   '加载中...',
//                   style: TextStyle(
//                     fontSize: 12,
//                     // fontWeight: FontWeight,
//                     color: Colors.grey[400],
//                   ),
//                 ),
//               ),
//             ),
//             errorWidget: (context, url, error) => Image.asset(
//               widget.errorImagePath,
//               width: widget.width,
//               height: widget.height,
//               fit: widget.fit,
//             ),
//           )
//         : Image.asset(
//             widget.errorImagePath,
//             width: widget.width,
//             height: widget.height,
//             fit: widget.fit,
//           );
//   }
// }
