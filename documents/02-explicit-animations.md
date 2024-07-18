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
- `AnimationController`는 `dispose()`에서 항상 명시적으로 dispose 시켜야 함
  - Animation이 실행중일 때 pop 등으로 widget이 사라지면 runtime error 발생
- Constructor
  - `duration` : forward animation 실행 시간
  - `reverseDuration` : reverse animation 실행 시간
  - `lowerbound`, `upperbound` : animation의 시작/끝 값 (`0.0` ~ `1.0` default)
- Controls
  - `forward()` : animation 재생
  - `stop()` : animaiton 정지
  - `reverse()` : animation 되감기 (역방향 재생)

### SingleTickerProviderMixin

- `Ticker` : calls its callback once per animation frame
- 앱이 60fps로 실행된다면, `Ticker`에 전달한 callback 함수는 1초에 60번 호출될 것
- `Ticker(callback)`을 실행하면 등록된 callback이 background에서 실행되는데, 어떤 screen에서 벗어나도 유지되는 문제가 있다.
- `SingleTickerProviderStateMixin`은 **실제로 `Ticker`를 사용하는 widget이 tree에 붙어서 enabled 되었을 때만 동작**하도록 관리해 준다.
- Ticker를 필요할 때만 실행시키므로 resource를 효율적으로 사용할 수 있다.
- `TickerProviderStateMixin`은 `AnimationController`가 여러 개일 때 ticker도 여러 개 사용하기 위한 것

### Tween과 AnimationController

- `Tween`은 animation의 시작/끝 value를 설정함 (Color는 `ColorTween` 사용)
- `Tween`을 만들고 `animate()` method에 `AnimationController`를 전달해서 animation value에 연결
  - 이 때, 연결된 값은 `Animation` type의 object
- `AnimationController`는 animation을 제어(control)하는 역할만 하고, animation value는 `Tween` 또는 `ColorTween`과 연결해서 사용하는게 좋다.
- `AnimationController`는 `lowerBounds`와 `upperBounds`의 `double` type 값만 사용할 수 있는데, `Tween`에 연결하면 `Tween`이 `lowerBounds`와 `upperBounds`의 값을 가지고 자신의 `begin`, `end` 값에 매핑해서 animation value를 계산해 준다.
- `lowerBounds`와 `upperBounds`의 기본값인 0과 1을 기준으로 `Tween`에서 설정한 `begin`, `end` 값을 계산하도록 만듦
  - `0.0` -> `Colors.amber`
  - `1.0` -> `Colors.red`
  - Animation이 동작하는 동안, 0에서 1 사이의 값으로 `amber`와 `red` 사이 색상값 계산

## AnimationBuilder

- Animation value를 UI로 보여주는 방법
- Animation frame마다 `setState`로 화면을 갱신하는 방법
  - `AnimationController.addListener`에 `setState`를 호출하는 listener 등록
  - 매 animation frame마다 `setState`가 호출되며 widget을 rebuild한다.
  - 화면 전체를 여러 번 빠르게 rebuild 하는 건 성능 상 좋지 않다.
- `AnimationBuilder` 사용
  - `AnimationController`의 값을 listen하고 있다가, 값이 변경되면 바뀐 값을 UI에 반영시켜 주는 widget
  - 매 animation frame마다`AnimationController.value`가 바뀔 때 UI를 update할 수 있는 widget
  - Explicit widget을 찾을 수 없을 때 사용하는게 좋다.

## Explicit animation widgets

- Flutter SDK는 `~Transition`으로 끝나는 build-in explicit animation widget을 제공함
- `AnimatedBuilder`만 여러 개 사용하는 것 보다, 용도에 맞는 `~Transition` widget을 사용하는게 가독성에 더 좋을 것
- `AnimationController` 하나를 여러 `Tween`에 연결해서 다수의 animation들에 대한 sync를 맞출 수 있다.
- `~Transition` widget에 넣어줄 `Animation` 값은 animation을 적용할 값에 대한 `Tween`으로부터 만든다.
  - `int`, `double`, `Offset` 등 단순한 type의 값이 필요하다면 `Tween` 사용
  - 그 외 object가 필요하다면 특화된 `~Tween` 사용
    - `Color` -> `ColorTween`
    - `Decoration` -> `DecorationTween`
- Widgets
  - `DecoratedBoxTransition`
    - `decoration`에 `Animation<Decoration>`을 받아서 decoration 속성에 대한 animation 실행
    - `DecorationTween`을 만들고 `animate()`로 `AnimationController`와 연결
  - `RotationTransition`
    - `turns`에 `Animation<double>`을 받아서 rotation animation 실행
    - `Tween`을 만들고 `animate()`로 `AnimationController`와 연결
  - `ScaleTransition`
    - `scale`에 `Animation<double>`을 받아서 scale animation 실행
    - `Tween`을 만들고 `animate()`로 `AnimationController`와 연결
  - `SlideTransition`
    - `position`에 `Animation<Offset>`을 받아서 translation animation 실행
    - `Offset` 값으로 `Tween`을 만들고 `animate()`로 `AnimationController`와 연결
    - 이 때, `Offset`은 상대적인 값(fractional). `width`가 400인데 400만큼 오른쪽으로 이동하고 싶다면 `dx`에 `1.0`을 넣어야 함

## CurvedAnimation

- `CurvedAnimation(parent,curve)`를 만들어서 curved animation 생성
  - `curve` : forward animation curve
  - `reverseCurve` : reverse animation curve
- `CurvedAnimation.parent`에 `AnimationController`를 넣어서 animation value 연결
- 이전에는 `Animation`을 만들기 위해 `animate`에 `AnimationController`를 넣었지만, 이제 `CurvedAnimation`을 사용해서 curved animation을 만들고 있으므로 `AnimationController` 대신 `CurvedAnimation`을 넣어준다.

## Animation value 변경하기

1. `forward()`, `reverse()` :
   - `AnimationController` 내부적으로 `value` 값을 animation frame마다 변경
2. `AnimationController.value`
   - Animation은 `AnimationController.value` 값이 변경될 때 마다 UI를 변경된 값으로 다시 그리는 것
   - 즉, `value` 값을 직접 바꾸면 특정 시점 UI를 animation 없이 얻을 수 있다.
3. `AnimationController.animateTo`
   - `animateTo` method를 사용하면 animation과 함께 특정 value에 해당하는 UI로 바뀐다.

## ValueNotifier

- Animation이 동작하는 동안 `AnimationController.value` 변경사항을 listen해서 다른 widget을 update
- `ValueNotifier`를 사용하면 값이 변경되었을 때 `setState`를 호출하지 않아도 특정 부분의 widget만 update 할 수 있다.
- `ValueNotifier.value`의 변경사항을 widget에서 listen하려면 `ValueListenableBuilder` 사용

## AnimationController Listener

- `AnimationController.addListener` : `value` 값이 변경될 때 마다 listener 호출
- `AnimationController.addStatusListener` : animation status가 변경될 때 마다 listener ghcnf
  - Animation의 상태(forward, reverse, completed, dismissed)를 listen
  - Animation이 끝났을 때(completed) 다른 animation을 실행시키는 등 구현

## Repeating animation

1. `AnimationController.addStatusListener`에 listener를 등록하고, status에 따라 `forward()` 또는 `reverse()` 실행
   ```dart
   late final AnimationController _animationController = AnimationController(
        ...
   )
   ..addStatusListener(
        (status) {
           // animation이 upperbounds에서 끝났을 때
           if (status == AnimationStatus.completed) {
               _animationController.reverse();
           }
           // animation이 lowerbounds에서 끝났을 때
           else if (status == AnimationStatus.dismissed) {
               _animationController.forward();
           }
        });
   ```
2. `AnimationController.repeat(min, max, reverse, period)` method 사용
   - `reverse`를 `true`로 설정해야 되감기로 동작
   - `min`, `max`로 반복 횟수를 조절할 수 있음
