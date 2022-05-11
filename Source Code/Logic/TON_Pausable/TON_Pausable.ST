//Timer start Input Off, reset variables.;
IF NOT IN THEN
	tTimePaused := T#0s;
	bTimedOut := False;
END_IF;


//Check for pause input, store ET at time of pause.
//rtPause(CLK := PAUSE);
rtPause(PAUSE);
IF rtPause.Q THEN
    tTimePaused := tTimePaused + Ton_A.ET;
END_IF;


//Timer Definition.
Ton_A(IN := IN AND NOT PAUSE, PT := PT - tTimePaused);


//Output States.
IF Ton_A.Q THEN
	bTimedOut := TRUE;
END_IF;
Q := bTimedOut;
ET := tTimePaused + Ton_A.ET;