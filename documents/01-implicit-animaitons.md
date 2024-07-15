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
