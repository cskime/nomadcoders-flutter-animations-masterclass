# Rive

- Animation을 만들어 주는 platform, package, application
- 어떤 trigger에 의해 animation이 실행되게 만들 수 있음
- 자체 editor를 통해 animation을 만들고 rive file format으로 export한 뒤 각 platform package를 통해 사용
- `rive` package로 사용
  - Rive website에서 rive animation들을 가져와서 사용할 수 있게 하는 package

## Rive 구성 요소

- Artboard : Animation을 그리는 layer 또는 board 단위?
- State machine
  - Rive animation을 만들 때 사용하는 animation state
  - Animation은 여러 개의 state의 조합으로 만들어진다.
- Input : Animation이 받는 user input

## Usage

### Load animation

- `RiveAnimation.asset` : `.riv` file path로 rive animation loading
- Rive editor를 통해 animation의 structure를 볼 수 있음
- 이 structure를 기반으로 app에서도 같은 이름으로 특정 element에 접근 가능
- `RiveAnimation.artboard` : 실행시킬 rive animation의 artboard 이름

### Get state machine

- `RiveAnimation.stateMachines` : 실행시킬 state machine 이름 list
- `RiveAnimation.onInit` : Rive animation이 초기화된 후 호출되는 함수
  - `Artboard` : animation이 위치한 layer
  - `StateMachineController.fromArtboard`로 `StateMachineController` 초기화
    - `artboard` : `onInput` 함수가 반환하는 `Artboard` 객체를 넣을 수 있음
    - `stateMachineName` : 가져올 state machine 이름
    - `onStateChange` : state 변경될 때 listener
  - 초기화한 controller를 artboard에 추가
    - Artboard는 animation이 재생되는 곳
    - State는 animation을 재싱시킴
    - Artboard에 state controller를 추가해서 animation을 재생시킨다.

### Get input

- Rive animation은 input 값에 따라 다르게 동작하도록 만들어져 있음
- `StateMachineController.findInput<T>(name)`으로 load된 animation이 갖고 있는 input을 가져옴
- `input.value`로 현재 input 값 가져오기
- `input.change`로 input 값 변경

## Custom Rive Animation

- Rive editor에서 custom animation 생성
- Timeline
  - State 1개
  - State machine이 언제 어떤 timeline을 표시할지 결정
  - Artboard에서 element를 선택한 뒤, timeline과 연결
  - Timeline에서 실제 animation을 만든다.
- Keyframe
  - Animation의 한 시점. 각 keyframe들이 animation을 다르게 보이게 함
  - Keyframe으로 저장할 속성을 지정해 두고 timeline에서 특정 시점에 element를 변형시키면, 변경된 상태가 keyframe으로 저장됨
  - 이렇게 저장된 keyframe들 사이에 animation이 생성된다.
