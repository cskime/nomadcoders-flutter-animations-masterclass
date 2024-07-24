# Animations Package

- `animations` : Material design의 animation을 구현해 둔 package
- Screen 사이 화면 전환 animation들을 사용할 수 있다.

## OpenContainer

- 두 widget 사이에 열고 닫는 animation을 구현하는 container widget
- 어떤 형태의 widget이든 부드러운 transition을 만들어 준다.
- Required properties
  - `openBuilder` : 새 화면을 열 때 rendering할 widget (destination widget 반환)
  - `closedBuilder` : 이전 화면으로 돌아갈 때 rendering할 widget (source widget 반환)
  - `closedBuilder`가 반환하는 widget을 tap하면 `openBuilder`에서 반환한 widget이 transition과 함께 나타남
- Optional
  - `elevation` : `OpenContainer`로 감싼 widget에 elevation을 적용해서 shadow를 넣어줌
  - `duration` : widget 사이 전환 속도 조절
