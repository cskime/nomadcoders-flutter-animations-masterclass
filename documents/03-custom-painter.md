# CustomPainter

- `Container`, `Row`, `Column` 등 Flutter SDK가 제공하는 widget으로 그릴 수 없는 UI를 그릴 수 있음

## CustomPaint

- `CustomPainter` 객체와 `Size`를 받아서 지정된 영역에 painter가 그리는 UI를 rendering 하는 widget
- `size`는 canvas size가 된다.

## CustomPainter

- 실제 UI를 그리는 object
- `CustomPainter` abstract class를 상속받고 2개 method를 override
  - `paint(canvas,size)`
    - `Canvas` object를 사용해서 painting code 작성
    - `CustomPaint.size`로 전달한 size가 parameter로 들어온다.
  - `shouldRepaint(oldDelegate)` : Repaint 여부 반환

### Canvas

- `Paint`로 rendering option 설정
  - `Paint()`로 instance 생성
  - `color`, `strokeWidth` 등 속성 설정
  - `canvas.draw~()`에 `Paint`를 필요로 하는 곳에 전달
- `draw~`로 canvas에 rendering
  - `drawRect(rect,paint)`
  - `drawCircle(offset,radius,paint)`
