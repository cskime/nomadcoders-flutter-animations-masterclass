# Music Player

- Album list와 music player 만들기

## PageView

- `PageController.viewportFraction`
  - Page item의 크기 조정
  - 이 page가 view를 얼마나 차지하는지 비율

## AnimatedSwitcher

- Child가 변경되면 animation을 받는 widget
- `child`에 다른 widget이 들어오면, 이전 widget이 새 widget으로 변환되는 animation을 만들어 준다.
- 즉, `child`를 이전과 다른 widget으로 변경해 주어야 함
- Flutter는 widget을 key를 사용해서 식별하므로, `child` widget의 key를 다르게 사용하면 이전/다음 widget을 다른 widget으로 식별할 수 있음

## BackdropFilter

- 아래에 깔린 widget들을 배경으로(backdrop) 만드는 filter를 적용할 수 있는 widget
- `BackdropFilter.filter`에 설정한 `ImageFilter`는 `child` widget에 적용된다.
- `ImageFilter.blur(sigmaX,sigmaY)`를 사용하면 gaussian blur filter를 사용할 수 있다.
