//Scale with Parameters//
//Paul Atkins, 05/02/2021//


//Enforce Range Limits//
IF ANY_TO_REAL(Input) < InMin THEN
	Temp := InMin;
ELSIF ANY_TO_REAL(Input) > InMax THEN
	Temp := InMax;
ELSE
	Temp := ANY_TO_REAL(Input);
END_IF;


//Scale input and map to output//
Output := ANY_TO_INT(	(Temp - InMin) / (InMax - InMin) * (OutMax - OutMin) + OutMin	);