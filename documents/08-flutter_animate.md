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

## Misc.

- `num`을 확장해서 `Duration`을 만들어 주는 extension 제공
  - `500.seconds` => `Duration(seconds: 5)`
