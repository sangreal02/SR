%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "ejemplo1.tab.h"
%}

digito [0-9]

%option yylineno
%option noyywrap

%%

{digito}+  {yylval.nval.ival=atoi(yytext);
			yylval.nval.tipo=1;	
			return ENT;}

{digito}*"."{digito}+  {yylval.nval.dval=atof(yytext);
						yylval.nval.tipo=2;
						return REAL;}

"("	{return LPAR;}

")"	{return RPAR;}

"+"	{return MAS;}

"*"	{return MUL;}

[ \t\n]	{}

.	{printf("Error léxico en la línea: %d, con el símbolo %s\n", yylineno ,yytext);}





