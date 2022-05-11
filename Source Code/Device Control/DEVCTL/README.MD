# IMPORTANT!
This block must have a 'RESETGOP' connected to the reset GOP output as well as having the 'RESETGOP' block connected to the global var for the GOP command.
Failure to do so will result in the global GOP variable not resetting to no command during an interlock event.
This means that if an interlock were to initiate a shutdown of a motor for example, as soon as the interlock condition cleared it would be reissued a start command.
An external block must be used because a UDF cannot modify the value of an input parameter... maybe there is a better way to do this, I am unsure.
