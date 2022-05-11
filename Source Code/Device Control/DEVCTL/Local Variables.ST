VAR_INPUT
    DI_1: BOOL;
    DI_2: BOOL;
    GOP: INT;				//Generic Output (oneshot from SFC)
    PI_0: BOOL := TRUE;		//Permissive - State 0
    PI_1: BOOL := TRUE;		//Permissive - State 1
    OI_0: BOOL;				//Override Interlock - State 0
    OI_1: BOOL;				//Override Interlock - State 1
    INTLK_BYPASS: BOOL;		//Bypass interlocks (used for test modes).
END_VAR
	
VAR_OUTPUT
	DO_1: BOOL;
    PV: INT := 4;		//Input State
    OP: INT := 4;		//Output State
    PV_DESC: STRING;	//Process Variable Text
    OP_DESC: STRING;	//Output Text
    CMDDIS_FL0: BOOL;	//Command Disagree Flag State0
    CMDDIS_FL1: BOOL;	//Command Disagree Flag State1
    UNCMD_FL: BOOL;		//Uncommanded Change Alarm
    S0_RDY: BOOL;		//State0 Ready (no interlocks present)
    S1_RDY: BOOL;		//State1 Ready (no interlocks present)
    GOP_NOCMD: BOOL;	//Triggers external block to set the GOP
 END_VAR
	
VAR	
	LastOP: INT;		//Previous Value Of OP
    GOP_TEMP: INT;		//Temporary GOP Value
    GOP_Last: INT;		//Value of GOP during the last execution cycle
    GOP_New: INT;		//New Value of GOP
    S0_TEXT: STRING := 'CLOSE';
    S1_TEXT: STRING := 'OPEN';
    CMDDIS_TON0: TON := T#0s;	//Command Disagree Timer State0
    CMDDIS_TON1: TON := T#0s;	//Command Disagree Timer State1
    CMDDIS_IN0: BOOL;			//Command Disagree Start State0
    CMDDIS_IN1: BOOL;			//Command Disagree Start State1
    CMDDIS_TM0: TIME;			//Command Disagree TIME State0
    CMDDIS_TM1: TIME;			//Command Disagree TIME State1
    LastPV: INT;
    GOP_4: R_TRIG;				//Only issue the command once.
    GOP_5: R_TRIG;				//Only issue the command once.
    GOP_EQ4: BOOL;
    GOP_EQ5: BOOL;
    ENABLE_INBET: BOOL := FALSE;	//Enable inbetween states
    SINBET_TEXT: STRING := 'TRAVELLING';
    SBAD_TEXT: STRING := 'BAD';
END_VAR