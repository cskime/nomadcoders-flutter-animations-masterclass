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

## Hero animation

- 화면 전환 시 `tag`가 같은 두 widget 사이에 부드러운 transition을 만들어 주는 widget
- Source route와 destination route에서 사용하는 `Hero` widget의 `tag`가 동일해야 함
