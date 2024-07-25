# Flutter Animate Package

- `AnimationController`, `Twwen` 등을 사용하지 않고 animation을 만들 수 있는 package

## Usage

- `Animate`로 animation을 적용하려는 widget 감싸기
  - `Animate.effects`에 적용하려는 animation effect 설정
    - `FadeEffect()` : fade in/out 효과
    - `ColorEffect()`
    - `CrossFadeEffect()`
    - `RotateEffect()`
    - `ScaleEffect()`
  - `~Effect`에서 animation 설정
    - `begin`, `end` : animation value의 시작/끝 값
    - `duration` ,`curve` : animation 재생 시간 및 curve
- Widget에 `animate()` method를 추가하고 shortcut method 사용
  - `animate()`가 반환하는 `Animate` object에서 `fadeIn()` 등 shortcut method 호출
    - `fade()` : `begin`, `end` 지정
    - `fadeIn()` : `begin`만 지정
    - `fadeOut()` : `end`만 지정
  - Shortcut method에서 `begin`, `end`에는 자동으로 0과 1이 설정된다.
  - `Animate` widget으로 감싸서 정의하는게 아니라, animation을 적용할 widget으로부터 `Animate` object를 가져다 사용하는 방식
- `then()`
  - 다른 shortcut method들을 연달아 호출할 때 중간에 `then()` 사용
  - `then()` 이전 animation들이 모두 끝난 뒤에 다음 animation 실행
  - `Interval`을 사용해서 연결되는 animation을 만드는 것에 활용 가능

## Misc.

- `num`을 확장해서 `Duration`을 만들어 주는 extension 제공
  - `500.seconds` => `Duration(seconds: 5)`
