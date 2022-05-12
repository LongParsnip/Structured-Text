//Generates an On/Off pattern when the input is on.

RSA(SET := IN, RESET1 := TON_2.Q);
TON_1(IN := RSA.Q1, PT := PT_ON);
TON_2(IN := TON_1.Q, PT := PT_OFF);


//Set Output.
IF IN AND NOT TON_1.Q THEN
	OUT := TRUE;
ELSE
	OUT := FALSE;
END_IF;