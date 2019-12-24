# zoomable_tilt_view
ZoomableTiltView is simple widget to add some juiciness to your app. 

## Usage

Simply import the package and wrap it inside ZoomableTiltView widget.

```dart
import 'package:zoomable_tilt_view/zoomable_tilt_view.dart';
```

## Example

```dart
ZoomableTiltView(
  yTiltLimit: 50,
  xTiltLimit: 50,
  tiltSensitivity: 1.5,
  zoomLimit: 1.8,
  child: Container(
    height: 200,
    width: 200,
    color: Colors.pinkAccent,
    child: Center(
      child: Text(
        "HIREME",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
),
```

## Parameters

| Parameter                           | Default                       | Description                                                                                       |
|-------------------------------------|-------------------------------|---------------------------------------------------------------------------------------------------|
| **yTiltLimit** int                      | 25                            | How much the child can tilt on Y axis\. Must be positive number\.                                 |
| **xTiltLimit** int                      | 25                            | How much the child can tilt on X axis\. Must be positive number\.                                 |
| **tiltSensitivity** double              | 1\.0                          | How much the child tilts\.                                                                        |
| **tiltResetAnimationDuration** Duration | Duration\(milliseconds: 900\) | How fast the tilt resets after you release the hold\.                                             |
| **zoomLimit** double                    | 1\.2                          | How much the child zooms when on press\.                                                          |
| **zoomAnimationDuration** Duration      | Duration\(milliseconds: 250\) | How long it takes to zoom in/out on press/release\.                                               |
| **zoomAlignment** Alignment             | Alignment\.center             | Which direction the child scales when pressed\. Useful if the child is near edges of the screen\. |
