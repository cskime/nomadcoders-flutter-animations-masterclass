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

## AnimationController

- `animateTo(target, curve)`
  - `AnimationController`의 value를 `target` 값으로 animation을 주면서 변경하는 방법
  - `curve`로 animation curve도 설정 가능
  - `AnimationController.value`에 직접 값을 넣는건 animation 없이 변경하는 것
- `AnimationController.value`에 직접 값을 더해 넣을 때, `lowerBound`와 `upperBound`에 제한되므로, 이 값을 더해지는 값의 범위로 바꿔주어야 함
  - `lowerBound`와 `upperBound`를 바꿀 때, 생성자에서 `value`를 0로 설정해 줘야 초기 위치를 initial position으로 잡을 수 있다.
