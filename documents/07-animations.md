# Animations Package

- `animations` : Material design의 animation을 구현해 둔 package
- Screen 사이 화면 전환 animation들을 사용할 수 있다.

## Container Transform

- 두 widget 사이 화면 전환 시 열고 닫는 transition
- `OpenContainer` widget을 사용하면 어떤 형태의 widget이든 부드러운 transition을 만들어 준다.
- Required properties
  - `openBuilder` : 새 화면을 열 때 rendering할 widget (destination widget 반환)
  - `closedBuilder` : 이전 화면으로 돌아갈 때 rendering할 widget (source widget 반환)
  - `closedBuilder`가 반환하는 widget을 tap하면 `openBuilder`에서 반환한 widget이 transition과 함께 나타남
- Optional
  - `elevation` : `OpenContainer`로 감싼 widget에 elevation을 적용해서 shadow를 넣어줌
  - `duration` : widget 사이 전환 속도 조절

## Shared Axis Animation

- 고정된 element는 그대로 두고 일부 widget만 변경할 때 사용
- `PageTransitionSwitcher` widget을 사용하고, `transitionBuilder`에서 `SharedAxisTransition`을 사용한다.
- `transitionBuilder`
  - `child` widget이 변경될 때 새 `child` widget에 animation 추가
  - `primaryAnimation` : child가 나타날 때(enterance) 및 사라질 때(exit) 동작하는 animation
  - `secondaryAnimation` : 새 content가 이존 child에 덮어질 때 (pushed on top of it) child에 적용되는 animation
  - `SharedAxisTransition`을 사용해서 shared axis animation 구현
    - `animation` : 새 child가 나타나고 사라지는 것을 위한 것
    - `secondaryAnimation` : transition에 의해 사라지는 자식을 위한 것
    - `transitionType`으로 transition 방향 결정 (`horizontal`, `vertical`, `scaled`)
    - `child` : Transition을 적용할 widget. `transitionBuilder`로 전달되는 `child`를 넣는다.
    - 이 때, `child` 자체가 바뀌어야 switcher가 다른 child로 인식하고 animation을 실행시킴
    - **따라서, `child` widget에 key를 부여해야 한다.**
- `duration`으로 switching animation 시간 설정

## Fade Through Animation

- 서로 관련 없는 UI 요소들 사이의 전환
- 이전 UI 사라지고 다른 UI가 나타나는 효과
- 화면의 일부 UI에 적용
- Shared axis animation과 비슷하게 `PageTransitionSwitcher` widget을 사용하고, `transitionBuilder`에서 `FadeThroughTransition`을 사용한다.
- `FadeThroughTransition`
  - `fillColor` : transition 중간에 background color 변경
