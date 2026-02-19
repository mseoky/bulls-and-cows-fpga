# Bulls and Cows FPGA

> **Note:** This project was developed as a term project for the **LOGIC CIRCUIT DESIGN & LAB** course at Pusan National University (December 2024, about 2 weeks).

## 📺 시현 영상 (Demo Video)
[![Bulls and Cows FPGA Demo](https://img.youtube.com/vi/KwwTgyxvh78/0.jpg)](https://youtu.be/KwwTgyxvh78)

## 📌 개요 (Overview)
- **과목명:** Logic Circuit Design & Lab
- **개발 기간:** 2024.12 (약 2주)
- **프로젝트 유형:** FPGA 기반 숫자야구 게임 (Bulls & Cows)
- **개발 도구:** Quartus Prime, Xilinx Vivado
- **타겟 보드:** Family `Spartan-7`, Part `xc7s75fgga484-1`
- **프로젝트 보고서:** [`report.pdf`](report.pdf)

## 🎯 프로젝트 목표 (Goal)
기존에 종이와 펜으로 진행하던 숫자야구 게임을 FPGA 보드 위에서 하드웨어 로직으로 구현하여,
난수 생성, 사용자 입력 처리, STRIKE/BALL 판정, 디스플레이 출력(7-segment/LCD), 상태 표시(LED)를 통합 동작시키는 것을 목표로 했습니다.

## 🔄 초기 계획 대비 변경 사항 (Changes from Initial Plan)
1. 초기 `S0B0` 표시 대신, 디버깅을 위해 7-segment 상위 4자리에 정답 난수 4자리를 표시
2. STRIKE/BALL 결과를 `STRIKE x BALL y` 형식으로 16x2 Text LCD에 출력
3. 9회 제한 제거, 무제한 시도로 변경 (매 시도마다 LED로 정답/오답 표시)
4. 결과별 음악 재생 기능은 최종 구현에서 제외

## 🕹 동작 시나리오 (How It Works)
1. 초기 상태에서 8-array 7-segment는 `00000000`, LCD에는 기본 결과 문자열이 표시됨
2. `*`(게임 시작) 입력 시 새 4자리 난수가 생성되고 7-segment 상위 4자리에 표시됨
3. 사용자가 4자리 숫자를 입력하면 7-segment 하위 4자리에 순차적으로 표시됨
4. `#`(제출) 입력 시 정답과 사용자 입력을 비교하여 LCD에 `STRIKE x BALL y` 출력
5. 정답(4 STRIKE)이면 초록 LED, 오답이면 빨간 LED 표시
6. 새 게임은 다시 `*`를 눌러 시작

## 🏗 시스템 구성 (Architecture)
- **입력부:** 키패드 입력, 시작(`gen_enable`) 및 제출(`submit`) 트리거
- **게임 로직:** 난수 생성(LFSR 기반), 4자리 비교, STRIKE/BALL 계산, 정답 판정
- **출력부:**
  - 8-array 7-segment: 정답(상위 4자리) + 사용자 입력(하위 4자리)
  - 16x2 Text LCD: `STRIKE x BALL y`
  - Full Color LED: 정답/오답 상태 표시
  - Piezo/Motor 연동 로직 포함(최종 데모에서는 핵심 게임 기능 위주 검증)

## 🧩 주요 모듈 설명 (Key Modules)
- `Bulls_and_Cows`: 최상위 통합 모듈
- `Password`: 난수 생성/입력 비교/정답 판정 제어
- `RandomNumberGenerator` (in `Password`): LFSR 기반 4자리 중복 없는 난수 생성
- `cnt_strike_ball` (in `Password`): STRIKE/BALL 계산
- `fourbit_comparator` (in `Password`): 4비트 단위 동등 비교
- `digits_to_ascii`: STRIKE/BALL 값을 LCD 문자열로 변환
- `lcd_controller`: LCD 초기화, clear, 문자열 출력 FSM
- `b2seg_bus`, `d2b`, `trigger`, `four_bit_reg_ce`, `count4`, `count8`, `LED`, `Piezo_module`: 입출력 및 보조 제어

## 🛠 기술 스택 (Tech Stack)
- HDL: Verilog
- EDA Tools: Quartus Prime, Xilinx Vivado
- Target Device: Spartan-7 (`xc7s75fgga484-1`)
- I/O Devices: Keypad, 8-array 7-segment, 16x2 LCD, RGB LED, Piezo

## 🗂 디렉토리 구조 (요약)
```text
/bulls-and-cows-fpga
  ├── Bulls_and_Cows/           # Top-level project
  ├── Password/                 # Game core logic
  ├── RandomNumberGenerator/    # LFSR-based number generation
  ├── cnt_strike_ball/          # Strike/Ball calculation
  ├── lcd_controller/           # LCD FSM controller
  ├── digits_to_ascii/          # LCD message formatter
  ├── b2seg_bus/                # 7-segment bus handling
  ├── LED/                      # LED status control
  ├── Piezo_module/             # Piezo control logic
  ├── ... (supporting modules)
  ├── report.pdf
  └── README.md
```

## 🚀 실행 및 검증 방법 (How to Run)
1. FPGA 프로젝트를 Quartus/Vivado 환경에서 열고 타겟 디바이스를 `xc7s75fgga484-1`로 설정합니다.
2. 소스를 컴파일(합성/구현)한 뒤 bitstream을 생성합니다.
3. 보드에 bitstream을 업로드합니다.
4. `*`로 게임 시작 후 4자리 입력, `#`로 제출하여 STRIKE/BALL 결과와 LED 상태를 확인합니다.

## 📄 참고 문서 (Documentation)
- 상세 설계 및 구현 배경: [`report.pdf`](report.pdf)
