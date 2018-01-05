%{
#include <stdio.h>
#include "semantic.tab.h"
%}

%option noyywrap
%option yylineno

%s comentario
%s comentariouna

letra [a-zA-Z]
digito [0-9]
espacio [ \t\n]
especial [tn0]
exp [eE]("+"|"-")?{digito}+

id {letra}|"_"({letra}|{digito}|"_")*
entero {digito}+
real {digito}*"."{digito}+{exp}?[fF]|{digito}+("."{digito}*)?exp?[fF]
cadena \"({espacio}|{letra}|\\{especial})+\"
caracter \'({espacio}|{letra}|\\{especial})\'

%%
<INITIAL>{
	";" { 
			yylval.line = yylineno;
			return PYC;
		}

	"," {
			yylval.line = yylineno;
			return  SEP;
		}

	":" {
			yylval.line = yylineno;
			return DP;
		}

	"." {
			yylval.line = yylineno;
			return PUNTO;
		}

	double {
			yylval.line = yylineno;
			return DOUBLE;
		}

	float {
			yylval.line = yylineno;
			return FLOAT;
		}

	int {
			yylval.line = yylineno;
			return INT;
		}

	char {
			yylval.line = yylineno;
			return CHAR;
		}

	string {
			yylval.line = yylineno;
			return STRING;
		}

	func { 
			yylval.line = yylineno;
			return FUNC;
		}

	void { 
			yylval.line = yylineno;
			return VOID;
		}

	struct {
			yylval.line = yylineno;
			return STRUCT;
		}

	print {
			yylval.line = yylineno;
			return PRINT;
		}

	if  { 
			yylval.line = yylineno;
			return IF;
		}

	else { 
			yylval.line = yylineno;
			return  ELSE;
		}

	switch {
			yylval.line = yylineno;
			return  SWITCH;
		}

	case {
			yylval.line = yylineno;
			return  CASE;
		}

	default {
			yylval.line = yylineno;
			return  DEF;
		}

	do {
			yylval.line = yylineno;
			return  DO;
		}	

	while {
			yylval.line = yylineno;
			return WHILE;}

	for {
			yylval.line = yylineno;
			return  FOR;
		}

	return {
			yylval.line = yylineno;
			return  RETURN;
		}	

	break { 
			yylval.line = yylineno;
			return BREAK;
		}

	{id} {  
			yylval.line = yylineno;
			yylval.sval = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(yylval.sval, yytext);
			return ID;
		}

	{real} {
				yylval.line = yylineno;
				yylval.nval.ival = atof(yytext);
				return REAL;
			}

	{entero} {
				yylval.line = yylineno;
				yylval.nval.fval = atoi(yytext);
				return ENT;
			}

	{caracter} {
				yylval.line = yylineno;
				yylval.sval = (char*)malloc(strlen(yytext)*sizeof(char));
				strcpy(yylval.sval, yytext);
				return CAR;
			}

	{cadena} {
				yylval.line = yylineno;
				yylval.sval = (char*)malloc(strlen(yytext)*sizeof(char));
				strcpy(yylval.sval, yytext);
				return CAD;
			}

	"{" { 
			yylval.line = yylineno;
			return LKEY;
		}

	"}" {   
			yylval.line = yylineno;
			return RKEY;
		}

	"[" { 
			yylval.line = yylineno;
			return LBRA;
		}

	"]" {   
			yylval.line = yylineno;
			return RBRA;
		}

	"=" {   
			yylval.line = yylineno;
			return ASIG;
		}

	"||" { 
			yylval.line = yylineno;
			return OR;
		}

	"&&" { 
			yylval.line = yylineno; 
			return AND; 
		}

	"!" {
			yylval.line = yylineno;
			return NOT;
		}

	"==" {  
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return EQUAL;
		}

	"!=" {  
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return NE;
		}

	">" {   
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return GT;
		}

	">=" {
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return GTE;
		}

	"<" {   
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return LT;
		}

	"<=" {
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return LTE;
		}

	true {
			yylval.line = yylineno;
			return  TR;
		}

	false {
			yylval.line = yylineno;
			return  FLS;
		}

	"+" { 
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return ADD;}

	"-" { 
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return SUB;}

	"*" {   
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return MUL;}

	"/" {   yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return DIV;}

	"%" {
			yylval.line = yylineno;
			strcpy(yylval.ssval, yytext);
			return MOD;
		}

	")" { 
			yylval.line = yylineno;
			return  RPAR;
		}

	"(" {
			yylval.line = yylineno;
			return LPAR;
		}

	{espacio}+ {}
	
	"//" { BEGIN comentariouna;}
	
	"/*"	{ BEGIN comentario;}
	  
	"*/"	{ printf("ERROR: %s en la línea %d\n", yytext, yylineno);}

	. { printf("ERROR: %s en la línea %d\n", yytext, yylineno);}
}

<comentario>{
	"*/"	{ BEGIN INITIAL;}
	[^*/]	{ }
	"/"    { }
	"*"  { }
}

<comentariouna>{
	\n	{ BEGIN INITIAL;}
	[^\n]	{ }
}

%%


