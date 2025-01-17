# Music Player

- Album list와 music player 만들기

## PageView

- `PageController.viewportFraction`
  - Page item의 크기 조정
  - 이 page가 view를 얼마나 차지하는지 비율
- `PageController`에 listener를 추가해서 어떤 page를 scroll하고 있는지 알 수 있다. (`addListener`)
  - Listener 안에서 `PageController.page` 속성을 통해 현재 가운데에 나타나는 page index를 알 수 있다.
  - Page를 이동하는 동안, destination page index로 이동하는 scroll offset 값이 반환된다.
  - 2 -> 3 page로 이동하고 있다면, 반환되는 값은 `2.0` ~ `3.0` 사잇값

## AnimatedSwitcher

- Child가 변경되면 animation을 받는 widget
- `child`에 다른 widget이 들어오면, 이전 widget이 새 widget으로 변환되는 animation을 만들어 준다.
- 즉, `child`를 이전과 다른 widget으로 변경해 주어야 함
- Flutter는 widget을 key를 사용해서 식별하므로, `child` widget의 key를 다르게 사용하면 이전/다음 widget을 다른 widget으로 식별할 수 있음

## BackdropFilter

- 아래에 깔린 widget들을 배경으로(backdrop) 만드는 filter를 적용할 수 있는 widget
- `BackdropFilter.filter`에 설정한 `ImageFilter`는 `child` widget에 적용된다.
- `ImageFilter.blur(sigmaX,sigmaY)`를 사용하면 gaussian blur filter를 사용할 수 있다.
- `BackdropFilter`라는 widget은 `child`에 `ImageFilter`를 적용하기 위한 용도. `child`에 투명도가 있어야 배경이 보인다.

## Hero animation

- 화면 전환 시 `tag`가 같은 두 widget 사이에 부드러운 transition을 만들어 주는 widget
- Source route와 destination route에서 사용하는 `Hero` widget의 `tag`가 동일해야 함

## Custom page transition

- `MaterialPageRoute` 대신 `PageRouteBuilder` 사용
- `transitionDuration`으로 transition 시간 변경 가능
- `pageBuilder`로 들어오는 `animation` 값을 사용해서 transition 구현 (Scale, slide, fade 등)
- `~Transition`으로 끝나는 explicit animation widget 사용

## Marquee

- 긴 text를 scroll해서 보여주는 HTML의 `marquee` element에서 따온 이름 (현재 deprecated)
- `AnimationController`와 `SlideTransition`을 사용해서 구현 가능
- `Text`는 `overflow`를 `TextOverflow.visible`로 설정하고, `softWrap`을 `false`로 설정해서 줄바꿈을 없애준다.

## AnimatedIcon

- Animation이 적용되는 icon 사용
- `icon`에 `AnimatedIcons.~`로 icon 설정
- `progress`에 animation value 전달
- Animation이 실행됨에 따라 `AnimatedIconData`에 미리 정의된 대로 animation 실행

## Lottie

- AirBnB에서 만든 animation package
- Flutter package를 사용하면 `AnimationController`로 lottie animation을 제어할 수 있다.
- 무료 animation들 사용 가능
- `Lottie.asset`으로 json file을 load
- `Lottie.controller`에 `AnimationController`를 전달해서 animation 재생 제어
- `Lottie.onLoaded` 함수로 들어오는 `composition.duration`을 `AnimationController.duration`에 전달해서 animation 재생시간을 동기화 시킬 수 있다.

```dart
Lottie.asset(
    "assets/animations/play-lottie.json",
    controller: _playPauseController,
    onLoaded: (composition) {
        _playPauseController.duration = composition.duration;
    },
    width: 200,
    height: 200,
),
```

## Staggered Animations

> 전체 animation 시간을 먼저 정하고, 그 시간 안에서 어떤 animation을 얼마나 실행시킬지 조절

- 일정 시간 동안에 여러 animation을 단계별로 나눠서 실행시키는 방법
- Animation에 사용할 각각의 `Tween`을 `animate` method를 사용해서 `Animation`으로 변환할 때, `AnimationController` 대신 `CurvedAnimation` 사용
- `CurvedAnimation.curves`에 `Curves` 대신 `Interval` class 사용
- `Interval` class : `Tween`을 animation에서 어떤 구간에 실행시킬지 설정
  - `begin` : 전체 animation에서 특정 `Tween` animation이 시작하는 지점 명시
  - `end` : 전체 animation에서 특정 `Tween` animation이 끝나는 지점 명시
  - `curves` : 구간 animation에 적용할 curve
  - `begin`과 `end`는 0과 1사이 비율값으로 `AnimationController.value` 범위를 나눔

## Tips

- `num` type에 대해 `clamp` method를 사용하면 이 method를 호출한 값을 `lowerLimit`과 `upperLimit` 사잇값으로 제한시킬 수 있다. `min` 또는 `max`를 사용하는 것 보다 간편
- Collection for 또는 collection if에서 두 개 이상의 widget을 넣고 싶을 때, spread 연산자(`...`)를 사용해서 widget들을 펼쳐주는 방식을 사용할 수 있다.
