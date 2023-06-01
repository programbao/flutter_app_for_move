import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final String errorImagePath;
  final BoxFit fit;

  const CustomImage({
    required this.url,
    this.width = 0.0,
    this.height = 0.0,
    this.errorImagePath = 'assets/img/loading-fail.png',
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(url, errorImagePath, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Image(
            image: snapshot.data as ImageProvider,
            width: width,
            height: height,
            fit: fit,
          );
        } else {
          return Image.asset(
            errorImagePath,
            width: width,
            height: height,
            fit: fit,
          );
        }
      },
    );
  }

  // Future<ImageProvider> _loadImage() async {
  //   try {
  //     final networkImage = NetworkImage(url);
  //     await networkImage.evict(); // 清除缓存以避免错误的图像显示
  //     var instance = await networkImage
  //         .obtainKey(const ImageConfiguration()); // 预加载图像以检查是否出现错误
  //     print(instance);
  //     return networkImage;
  //   } catch (error) {
  //     debugPrint('Failed to load image from URL: $url');
  //     return AssetImage(errorImagePath);
  //   }
  // }
  Future<ImageProvider> _loadImage(
      String url, String errorImagePath, BuildContext context) async {
    try {
      final networkImage = NetworkImage(url);
      await networkImage.evict(); // 清除缓存以避免错误的图像显示
      // ignore: use_build_context_synchronously
      final imageConfig = createLocalImageConfiguration(context);
      final completer = Completer<ImageProvider>();

      networkImage.resolve(imageConfig).addListener(
            ImageStreamListener(
              (ImageInfo imageInfo, bool synchronousCall) {
                // 图像加载成功
                completer.complete(networkImage);
              },
              onError: (dynamic error, StackTrace? stackTrace,
                  {String? context}) {
                // 图像加载失败，例如404错误
                debugPrint('Failed to load image from URL: $url');
                completer.complete(AssetImage(errorImagePath));
              },
            ),
          );

      return completer.future;
    } catch (error) {
      debugPrint('Failed to load image from URL: $url');
      return AssetImage(errorImagePath);
    }
  }
}
