//This must be used along side the DEVCTL block in order to reset the GOP input parameter if an override condition occurs.
//The reason for this is that the DEVCTL block cannot change the value of input parameters, this must be done externally.
//Usage:
//		1.) Connect DEVCTL.GOP_NOCMD To the IN parameter.
//		2.)	Connect the GOP input variable to the IN_GOP parameter.
//		3.) Connect the GOP input variable to the OUT_GOP parameter.


//Why doesn't FBD allow you to access the EN parameter of the MOV block....
IF IN THEN	OUT_GOP := 0;	ELSE	OUT_GOP := IN_GOP;	END_IF;