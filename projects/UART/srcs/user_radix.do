onerror {resume}


radix define UART_FSM {
    "2'b00"     "IDLE"   -color #F1F10B,
    "2'b01"     "START"  -color #89F10B,
    "2'b10"     "DATA"   -color #0BF1CB,
    "2'b11"     "STOP"   -color #0B93F1,
    -default hexadecimal
}

