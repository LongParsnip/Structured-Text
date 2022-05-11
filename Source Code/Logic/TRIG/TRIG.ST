//Trigger Block.
//	* R_Trig and F_Trig selectable as well as TON or TOF function.
//	* Time delay selectable.	(TIME_DELAY variable) Default: T#1s

TON_1(IN := IN, PT := TIME_DELAY);
TOF_1(IN := IN, PT := TIME_DELAY);

RISING_TON(CLK := TON_1.Q);
RISING_TOF(CLK := TOF_1.Q);
FALLING_TON(CLK := TON_1.Q);
FALLING_TOF(CLK := TOF_1.Q);

	//Set block outputs.
	RTRIG_TON := RISING_TON.Q;
	RTRIG_TOF := RISING_TOF.Q;
	FTRIG_TON := FALLING_TON.Q;
	FTRIG_TOF := FALLING_TOF.Q;