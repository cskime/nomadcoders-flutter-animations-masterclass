# Explicit Animations

## Implicit vs. Explicit

- Implicit animation은 trigger만 줄 뿐 구체적인 구현은 작성하지 않음
- Explicit animation은 animation 동작을 모두 제어하고 구체적인 animate code 작성
  - 멈춤, 건너뛰기, 되감기, 재생, 반복 재생 등
- 여러 animation을 연결하거나, animation 뒤에 다른 animation이 이어서 동작하게 하는 등 복잡한 제어 가능

## Which animations shoud I use and when?

- Flutter document에 언제 어떤 animation을 사용해야 하는지 [가이드](https://docs.flutter.dev/assets/images/docs/ui/animations/animation-decision-tree.png)를 제공함
- Text style에 animation을 주고 싶다? -> `AnimatedDefaultTextStyle`
- 제어할 필요 없는 선형적 animation & animating a single child? -> Implicit animation (`AnimatedFoo` or `TweenAnimationBuilder`)
- 더 많은 제어를 원한다면? -> Explicit animation (`FooTransition` or `AnimatedBuilder` or `AnimatedWidget` subclass)
- `Row`, `Column` 같은 standard layout을 사용할 수 없다면? -> `CustomPainter`에 animation 적용

## AnimationController

- `AnimationController`를 사용해서 animation을 제어할 수 있다.
- `AnimationController` 생성 시 `vsync`에 `TickerProvider` subclass를 넣어준다.
  - 일반적으로 `State` class에서 `AnimationController`를 property로 가짐
  - `State` class에 `SingleTickerProviderStateMixin`을 mixed in 하고, `vsync`에 `this` 전달
  - `AnimationController`로 animation을 실행시킬 때, device의 주사율에 맞춰 빠르고 부드러운 animation을 실행시킬 수 있도록 `Ticker`를 사용한다.
  - Animation 실행 코드를 `Ticker`의 callback으로 등록해서 매 animation frame마다 실행되도록 만드는 것
- Constructor
  - `duration` : animation 실행 시간
  - `lowerbound`, `upperbound` : animation의 시작/끝 값 (`0.0` ~ `1.0` default)
- Controls
  - `forward()` : animation 재생
  - `stop()` : animaiton 정지
  - `reverse()` : animation 되감기 (역방향 재생)

### Communication between UI and a value of AnimationController

1. Animation frame마다 `setState`로 화면 갱신
   - `AnimationController.addListener`에 `setState`를 호출하는 listener 등록
   - 매 animation frame마다 `setState`가 호출되며 widget을 rebuild한다.
   - 화면 전체를 여러 번 빠르게 rebuild 하는 건 성능 상 좋지 않은 방법
2. `AnimationBuilder` 사용
   - `AnimationController`의 값을 listen하고 있다가, 값이 변경되면 바뀐 값을 UI에 반영시켜 주는 widget
   - 매 animation frame마다`AnimationController.value`가 바뀔 때 UI를 update할 수 있는 widget
3. `Tween` 사용
   - `Tween`은 animation의 시작/끝 value를 설정함
   - `AnimationController` value를 `Tween`에 연결해서 사용

### SingleTickerProviderMixin

- `Ticker` : calls its callback once per animation frame
- 앱이 60fps로 실행된다면, `Ticker`에 전달한 callback 함수는 1초에 60번 호출될 것
- `Ticker(callback)`을 실행하면 등록된 callback이 background에서 실행되는데, 어떤 screen에서 벗어나도 유지되는 문제가 있다.
- `SingleTickerProviderStateMixin`은 **실제로 `Ticker`를 사용하는 widget이 tree에 붙어서 enabled 되었을 때만 동작**하도록 관리해 준다.
- Ticker를 필요할 때만 실행시키므로 resource를 효율적으로 사용할 수 있다.
- `TickerProviderStateMixin`은 `AnimationController`가 여러 개일 때 ticker도 여러 개 사용하기 위한 것
