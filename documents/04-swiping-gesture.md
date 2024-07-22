# Swiping Gesture

## Swipe gesture 감지

- `GestureDetector`로 사용자 gesture 감지
- `onHorizontalDragUpdate` : element를 horizontal 방향으로 drag 할 때 호출
  - `DragUpdateDetails`로 drag 정보를 얻음
  - `details.delta` : mouse가 움직인 양
  - `details.delta.dx` 또는 `details.delta.dy`를 모두 더해서 element를 움직여야 하는 양을 계산
- `onHorizontalDragEnd` : horizontal drag가 끝났을 때 호출

## Card 움직이기

- `Transform` : layout 직전에 지정한 transform을 적용해 주는 widget
- `Transform.translate` : Translate transform을 적용하는 named constructor
