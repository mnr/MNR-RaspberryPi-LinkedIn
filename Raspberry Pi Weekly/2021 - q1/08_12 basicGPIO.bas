      REM credit to Richard Thomas Russell, creator of BBC BASIC. http://www.rtrussell.co.uk
      REM details at https://www.raspberrypi.org/forums/viewtopic.php?t=175703
      REM based on code at https://elinux.org/RPi_GPIO_Code_Samples#Direct_register_access

      INSTALL @lib$ + "gpiolib"
      INSTALL @lib$ + "stringlib"

      gpio% = FN_gpio_setup

      FOR pin% = 9 TO 11
        PROC_gpio_inp(gpio%,pin%)
        PROC_gpio_out(gpio%,pin%)
      NEXT pin%

      previous% = %111110000000
      FOR pattern% = %000000000000 TO %111111000000 STEP %10000000
        PROC_gpio_clr(gpio%, (pattern% EOR previous%) AND NOT pattern%)
        PROC_gpio_set(gpio%, (pattern% EOR previous%) AND pattern%)
        previous% = pattern%
        WAIT 20
        PRINT FN_tobase(gpio%!&34 >> 7 AND %11111, 2, 5)
      NEXT pattern%

      PROC_gpio_clr(gpio%, %111111000000)

      PRINT "Finished"
