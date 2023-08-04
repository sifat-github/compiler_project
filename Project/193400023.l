/* C Declarations */

%{
	#include<stdio.h>
	#include "193400023.tab.h"
	#include<stdlib.h>
	extern int yylval;
%}

%%

"int"	{ return INT; }
"float"	{ return FLOAT; }
"char"	{ return CHAR; }


[0-9]+	{ 
		yylval = atoi(yytext);
		return NUM;
	}
	
"("		{ return left_B; }
")"		{ return right_B; }
"{"		{ return left_SB; }
"}"		{ return right_SB; }
","		{ return darao; }
"?"		{ return thamo; }
"+"		{ return jog; }
"-"		{ return biug; }
"x"		{ return gun; }
"/"	    { return vag; }
"="		{ return ASSIGN;  }
">"		{ return GT; }
"<"		{ return LT; }
">="	{ return GTequal; }
"<="	{ return LTequal; }
"++"    { return inc; }
"hi"	{ return start; }
"bye"	{ return end; }
"^"   	{ return POW; }

[a-z]	{
		yylval = *yytext - 'a';
		return	VAR;
	}			

"if"      	{ return jodi; }

"else"    	{ return othoba; }
"for"  	  	{ return jonno; }

"while" 	{ return jokhon; }


[ \t\n]*	;

@	{
		yyerror("Unknown Character.\n");
	}

%%

/* user subroutines */

int main()
{
	yyin = freopen("193400023.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();

}

