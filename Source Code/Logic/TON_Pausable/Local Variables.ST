VAR_INPUT
	IN: BOOL;
	PT: TIME;
	PAUSE: BOOL
END_VAR

VAR_OUTPUT
	Q: BOOL;
	ET: TIME;
END_VAR

VAR
	rtPause: R_TRIG;
	tTimePaused: TIME;
	Ton_A: TON;
	bTimedOut: BOOL;		//Prevents Ton_A.Q from resetting if paused when timed out.
END_VAR