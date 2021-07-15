/* Macro assignment to retrieve current user and create unique identifiers */
%let suffix = %substr(&_CLIENTUSERID,%length(&_CLIENTUSERID)-2,3);

/* Start a session named my Session to the CAS server */
CAS mySession SESSOPTS=(CASLIB=casuser TIMEOUT=99 LOCALE="en_US");

/* Create a session scoped CAS library (demoxxx) for the path "/home/gatedemoxxx" */
CASLIB demo&suffix PATH="/home/gatedemo&suffix" TYPE=path;

/* Load a data table to CAS under caslib demoxxx */
PROC CASUTIL;
	LOAD DATA=sashelp.air OUTCASLIB="demo&suffix"
	CASOUT="air";
RUN;

/* Show CASLIB in SAS Studio */
CASLIB _ALL_ ASSIGN;

/* List CAS table information from caslib demoxxx */
proc casutil;
	list tables incaslib="demo&suffix";
run;

%let suffix = %substr(&_CLIENTUSERID,%length(&_CLIENTUSERID)-2,3);

CAS mySession2 SESSOPTS=(CASLIB=casuser TIMEOUT=999 LOCALE="en_US");

/* List CAS table information from caslib demoxxx */
proc casutil;
	list tables incaslib="DEMO&suffix";
run;

CAS mySession TERMINATE;
CAS mySession2 TERMINATE;