import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/widgets/salt_animated_loader.dart';

class SweaterImageWrapper extends StatelessWidget {
  final double size;
  final double padding;
  final String? imageSrc, chipSrc;

  const SweaterImageWrapper({
    Key? key,
    required this.size,
    this.padding = StyleConstants.kDefaultPadding,
    this.imageSrc,
    this.chipSrc,
  }) : super(key: key);

  Widget _buildImageContainer() {
    if (imageSrc != null && chipSrc != null) {
      return _ImageSlider(
        imagesSrc: [imageSrc!, chipSrc!],
        size: size,
      );
    }

    if (imageSrc != null) {
      return Image.asset(
        imageSrc!,
        fit: BoxFit.cover,
        height: size,
        width: size,
      );
    }

    if (chipSrc != null) {
      return chipSrc!.contains('assets')
          ? Image.asset(
              chipSrc!,
              fit: BoxFit.cover,
              height: size,
              width: size,
            )
          : _NetworkImage(
              imageUrl: chipSrc!,
              size: size,
            );
    }

    return SaltAnimatedLoader(size: size);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Center(
        child: _buildImageContainer(),
      ),
    );
  }
}

class _ImageSlider extends StatefulWidget {
  final List<String> imagesSrc;
  final double size;

  const _ImageSlider({
    Key? key,
    required this.imagesSrc,
    required this.size,
  }) : super(key: key);

  @override
  State<_ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<_ImageSlider> {
  final CarouselController _controller = CarouselController();
  int _currentImage = 0;

  void _onImageChangedHandler(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentImage = index;
    });
  }

  void _onSwapIndicatorHandler(int index) {
    _controller.animateToPage(index);
  }

  void _onChangeImageHandler(bool toNext) {
    toNext ? _controller.nextPage() : _controller.previousPage();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: widget.size,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            onPageChanged: _onImageChangedHandler,
          ),
          items: widget.imagesSrc.map((image) {
            return image.contains('assets')
                ? Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: widget.size,
                    width: widget.size,
                  )
                : _NetworkImage(
                    imageUrl: image,
                    size: widget.size,
                  );
          }).toList(),
        ),
        Positioned(
          left: 0.0,
          child: _NavigationButton(
            size: isLargeScreen ? widget.size * 0.16 : widget.size * 0.2,
            isLeft: true,
            callback: _onChangeImageHandler,
          ),
        ),
        Positioned(
          right: 0.0,
          child: _NavigationButton(
            size: isLargeScreen ? widget.size * 0.16 : widget.size * 0.2,
            isLeft: false,
            callback: _onChangeImageHandler,
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imagesSrc.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _onSwapIndicatorHandler(entry.key),
                child: Container(
                  height: 12.0,
                  width: 12.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(_currentImage == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _NetworkImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const _NetworkImage({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: SaltAnimatedLoader(
              size: size - StyleConstants.kDefaultPadding * 3.0,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Center(
            child: Text('Error: ${error.runtimeType}'),
          );
        },
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final double size;
  final bool isLeft;
  final Function(bool) callback;

  const _NavigationButton({
    Key? key,
    required this.size,
    required this.isLeft,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(!isLeft),
      child: Container(
        height: size,
        width: size,
        color: Colors.grey.shade800.withOpacity(0.5),
        child: Center(
          child: Image.asset(
            isLeft
                ? 'assets/icons/slider_left.png'
                : 'assets/icons/slider_right.png',
            height: size * 0.5,
            width: size * 0.5,
          ),
        ),
      ),
    );
  }
}
