; Define pins for ULN2003 stepper motor driver
Pins equ P1

; Define delay time between steps (in milliseconds)
DelayTime equ 1000

; Define sequence of motor steps
Sequence:   db  0x01, 0x02, 0x04, 0x08

; Define variables
Counter:    db  0

; Initialize microcontroller
    mov     Pins, #0x00         ; Set all pins to low
    mov     TMOD, #0x01         ; Set Timer0 as 16-bit timer
    mov     TH0, #0xFC          ; Set Timer0 initial value (65536 - 5000)
    mov     TL0, #0x18          ; Set Timer0 initial value (65536 - 5000)
    setb    TR0                 ; Start Timer0
    setb    ET0                 ; Enable Timer0 interrupt
    setb    EA                  ; Enable global interrupt

; Timer0 interrupt service routine
Timer0_isr:
    clr     TF0                 ; Clear Timer0 interrupt flag
    mov     A, #Counter
    anl     A, #03h             ; Keep only lower 2 bits of counter
    mov     DPL, A
    mov     A, #Sequence
    add     A, DPL              ; Add counter to sequence address
    mov     A, @A               ; Get value at sequence address
    mov     Pins, A             ; Set pins to motor step
    reti                        ; Return from interrupt

; Main program
Main:
    sjmp    $                   ; Wait for interrupt
end