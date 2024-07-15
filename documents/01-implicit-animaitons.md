# Implicit Animations

- Animation : a **transition** from one state to the other
- Opacity의 경우 0, 0.1, 0.2, ..., 1.0 으로 서서히 바뀌는 것
- Implicit : not directly expressed (암묵적인)

## Implicit animation widget

- Animation을 직접 만들지 않아도 widget을 사용하기만 하면 알아서 animation이 만들어지고 실행됨
- Animation이 실행되지만 animation 관련 코드를 작성하지 않음
- `Animated~`로 시작하는 widget들을 사용한다.
  - `AnimatedOpacity` : opacity에 animation 적용
  - `AnimatedAlign` : alignment에 animation 적용
  - `AnimatedContainer` : `Container`에서 사용할 수 있는 모든 요소에 대해 animation 적용
- Animation을 일시정지 하는 등 detail한 설정을 할 수는 없지만, 단순한 animation을 쉽게 적용할 수 있다는 장점이 있다.

## Curves

- Animation이 실행되는 curve 함수 설정
- `Curves` abstract class의 static 속성들 사용
- Default는 `Curves.linear`

## TweenAnimationBuilder

- Implicit animation widget을 직접 만들 수 있는 builder widget
- Built-in implicit animation widget 중에서 필요한 것을 찾지 못하면 `TweenAnimatedBuilder`를 사용해서 implicit animation을 직접 만들 수 있다.
- `Tween`
  - target of the animation
  - animation의 시작과 끝 값을 지정해서 범위를 만든다.
  - animation은 `Tween`의 `begin`과 `end` 사이의 값으로 만들어진다.
- `ColorTween` : `Tween`의 color version
- `TweenAnimationBuilder`
  - `tween`
    - Animation target
    - `begin`, `end` 사잇값을 계산해서 `builder` 함수로 전달한다.
  - `builder`
    - `value`로 animation value가 전달된다.
    - `value` 값을 사용하는 widget을 반환해서 매 animation frame마다 변화된 widget을 보여준다.
    - Widget이 빠르게 바뀌면서 animation 처럼 보이게 된다.
