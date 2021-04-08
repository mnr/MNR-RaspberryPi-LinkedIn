# this is a comment

library(cowsay)

say("Hello world")

# plot(x = 1:10, y = 10:1)

# controlling the GPIO
hellobob <- system("pwd", intern=TRUE)
print(paste("here i am", hellobob))

doExampleOne <- TRUE
#### Example 1 #################################
# assign buttons
btnAlpha <- 15 # BCM numbering scheme
btnGamma <- 14
LEDred <- 9
LEDblue <- 10
LEDgreen <- 11


while (doExampleOne) {
	getGPIOcmd <- paste("gpioget gpiochip0", btnAlpha)
	if (system(getGPIOcmd, intern = TRUE) == 0) {
		print("Alpha")
		setGPIOcmd <- paste0("gpioset --mode=time --sec=1 gpiochip0 ", 
							LEDred,"=", sample(0:1,1), " ",
							LEDblue,"=", sample(0:1,1), " ",
							LEDgreen,"=", sample(0:1,1))
		print(setGPIOcmd)
		system(setGPIOcmd)
	}
	getGPIOcmd <- paste("gpioget gpiochip0", btnGamma)
	if (system(getGPIOcmd, intern = TRUE) == 0) print("Gamma")

}
# control-Z stops the loop
		
#### Example 2 ##################################
# assign buttons as a vector
allBtns <- c(15,14)

while (!doExampleOne) {
	getGPIOcmd <- paste("gpioget --active-low gpiochip0 ", paste(allBtns, collapse= " "))
	#whatIsThis <- system(getGPIOcmd, intern = TRUE)
	#whatIsThis
	pinState <- system(getGPIOcmd, intern = TRUE)
	gpioPins <- as.integer(unlist(strsplit(pinState, " ")))
	if (any(gpioPins)) { 
		print(paste("a=",gpioPins[1]," b=",gpioPins[2]))
	}
	if (all(gpioPins)) {
		print("all buttons are pressed")
	}
	if (!any(gpioPins)) {
		print("no buttons are pressed")
	}

}

