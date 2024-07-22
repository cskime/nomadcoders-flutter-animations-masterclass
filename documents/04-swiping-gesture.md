# Swiping Gesture

- `AnimationController` 하나로 여러 animation 및 motion의 sync를 맞추는 방법
- `AnimationController`를 사용해서 여러 `Tween` animation을 만들 수도 있고,
- `AnimatedBuilder.animation`에 `AnimationController`를 넣어서 하나의 animation value를 여러 곳에서 사용할 수도 있다.
- `Tween`은 단순히 값의 범위라서 `value`로 값을 가져올 수 없는데, animation value를 `Tween.transform`을 사용해서 tween value로 변환시킬 수 있다.
- 이렇게 `transform`으로 변환한 값은 `Tween.animate`로 만들어지는 animation value와 동일함

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
  - `whenComplete` method로 animation 완료 후 callback을 실행시킬 수 있다.
- `AnimationController.value`에 직접 값을 더해 넣을 때, `lowerBound`와 `upperBound`에 제한되므로, 이 값을 더해지는 값의 범위로 바꿔주어야 함
  - `lowerBound`와 `upperBound`를 바꿀 때, 생성자에서 `value`를 0로 설정해 줘야 초기 위치를 initial position으로 잡을 수 있다.

## Transforming Tween

- Animation interpolation을 위해 `Tween` 사용
- Interpolation
  - translating one value to another
  - 서로 다른 값의 sync를 맞추어야 함
  - TranslationX가 250일 때 rotation이 15가 되는 연산을 대신하는 것
- `Tween.transform(t)`
  - current animation value를 다른 value로 interpolation
  - `t` : animation value
  - `t`가 0이면 `begin`을, `t`가 1이면 `end`를 반환
  - `t`가 0 또는 1이 아니면 `lerp(t)` 함수의 반환값을 반환
  - `lerp(t)`는 `begin + (end - begin) * value`로 계산. 즉, `begin`에서 시작해서 `value`만큼의 값을 더해서 범위 안에 특정 값을 반환한다.
  - `AnimationController`의 `lowerBound`와 `upperBound`를 다른 값으로 변경하는 경우(e.g. `-width ~ width`), animation value를 0과 1 사이 값으로 정규화한 뒤 `t`에 넣어주면 해당 `Tween`에서의 값으로 변환 수 있다.

## Transform

- `Transform` : `child`에 transform을 적용하는 widget
- `~Transition`은 explicit animation을 위한 widget. `Transform`은 animation이 고려되지 않음
- `Transform.translate` : `Offset` 만큼 `child`의 위치를 이동시키는 widget
- `Transform.scale` : `double` scale 만큼 `child`의 크기를 변경하는 widget
- `Transform.rotate` : `double` angle 만큼 `child`의 크기를 변경하는 widget
