library zoomable_tilt_view;

import 'package:flutter/material.dart';

class ZoomableTiltView extends StatefulWidget {
  // How much view can be tilted on Y and X axis
  final int yTiltLimit;
  final int xTiltLimit;

  final double tiltSensitivity;
  final Duration tiltResetAnimationDuration;

  // How much the child zooms when pressed
  final double zoomLimit;

  // How fast the child zooms in and out
  final Duration zoomAnimationDuration;

  // Where the zoom starts
  final Alignment zoomAlignment;

  final Widget child;

  ZoomableTiltView({
    Key key,
    @required this.child,
    this.yTiltLimit = 25,
    this.xTiltLimit = 25,
    this.tiltSensitivity = 1.0,
    this.tiltResetAnimationDuration = const Duration(milliseconds: 900),
    this.zoomLimit = 1.2,
    this.zoomAnimationDuration = const Duration(milliseconds: 250),
    this.zoomAlignment = Alignment.center,
  })  : assert(child != null),
        assert(yTiltLimit >= 0),
        assert(xTiltLimit >= 0),
        assert(tiltSensitivity >= 0),
        super(key: key);

  @override
  _ZoomableTiltViewState createState() => _ZoomableTiltViewState();
}

class _ZoomableTiltViewState extends State<ZoomableTiltView>
    with TickerProviderStateMixin {
  // Tilt animation
  AnimationController _xController;
  AnimationController _yController;

  // Zoom animation
  AnimationController _zoomController;
  Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();
    _zoomController = AnimationController(
      vsync: this,
      duration: widget.zoomAnimationDuration,
    );
    _zoomAnimation = Tween<double>(
      begin: 1.0,
      end: widget.zoomLimit,
    ).animate(CurvedAnimation(
      parent: _zoomController,
      curve: Curves.easeInCubic,
    ))
      ..addListener(() {
        setState(() {
          //
        });
      });

    _xController = AnimationController(
      vsync: this,
      lowerBound: -(widget.xTiltLimit).toDouble(),
      upperBound: widget.xTiltLimit.toDouble(),
      duration: widget.tiltResetAnimationDuration,
    );
    _xController.addListener(() {
      setState(() {
        //
      });
    });

    _yController = AnimationController(
      vsync: this,
      lowerBound: -(widget.yTiltLimit).toDouble(),
      upperBound: widget.yTiltLimit.toDouble(),
      duration: widget.tiltResetAnimationDuration,
    );
    _yController.addListener(() {
      setState(() {
        //
      });
    });

    _xController.value = 0.0;
    _yController.value = 0.0;
  }

  @override
  void dispose() {
    _zoomController.dispose();
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      alignment: widget.zoomAlignment,
      scale: _zoomAnimation.value,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(
              _yController.value * 0.01) // ? Is the Y and X values reversed?
          ..rotateY(_xController.value * -0.01),
        alignment: FractionalOffset.center,
        child: GestureDetector(
          onPanUpdate: (details) {
            if ((_xController.value + details.delta.dx >=
                    -(widget.xTiltLimit)) &&
                (_xController.value + details.delta.dx <= widget.xTiltLimit)) {
              _xController.value = _xController.value +=
                  (details.delta.dx * widget.tiltSensitivity);
            }

            if ((_yController.value + details.delta.dy >=
                    -(widget.yTiltLimit)) &&
                (_yController.value + details.delta.dy <= widget.yTiltLimit)) {
              _yController.value = _yController.value +=
                  (details.delta.dy * widget.tiltSensitivity);
            }
          },
          onPanStart: (_) {
            _zoomController.forward();
          },
          onPanEnd: (details) {
            if (widget.yTiltLimit > 0) {
              _yController.animateTo(0.0, curve: Curves.easeOutBack);
            }
            if (widget.xTiltLimit > 0) {
              _xController.animateTo(0.0, curve: Curves.easeOutBack);
            }
            _zoomController.reverse();
          },
          child: widget.child,
        ),
      ),
    );
  }
}
