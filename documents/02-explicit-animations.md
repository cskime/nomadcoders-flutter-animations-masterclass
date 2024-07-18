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
