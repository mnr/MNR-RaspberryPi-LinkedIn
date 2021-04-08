       IDENTIFICATION DIVISION.
       PROGRAM-ID. RPIwithCOBOL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
        01 WS-GPIO-INIT PIC x(40) VALUE 'echo "21" > /sys/class/gpio/export'.
        01 WS-GPIO-DIR PIC x(50) VALUE 'echo "out" > /sys/class/gpio/gpio21/direction'.
        01 WS-GPIO-ON PIC x(40) VALUE 'echo "1" > /sys/class/gpio/gpio21/value'.
        01 WS-GPIO-OFF PIC x(40) VALUE 'echo "0" > /sys/class/gpio/gpio21/value'.
        01 WS-GPIO-ClR PIC x(40) VALUE 'echo "21" > /sys/class/gpio/unexport'.        
        
        PROCEDURE DIVISION.
        display "This is COBOL running on a Raspberry Pi".
        display "Here's how to call GPIO from COBOL".
        CALL "SYSTEM" USING WS-GPIO-INIT.
        CALL "SYSTEM" USING WS-GPIO-DIR.
        PERFORM FLASH-LITE 3 TIMES.
        CALL "SYSTEM" USING WS-GPIO-CLR.
        STOP RUN.
   
        FLASH-LITE.
        CALL "SYSTEM" USING WS-GPIO-ON.
        display "LED is ON".
        CALL "C$SLEEP" USING 1.
        CALL "SYSTEM" USING WS-GPIO-OFF.
        display "LED is OFF".
        CALL "C$SLEEP" USING 1.
           
        END PROGRAM RPIwithCOBOL.

