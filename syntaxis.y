%{
#include <stdio.h>
#include <string.h>
#include "symbols.h"

extern FILE *yyin;
extern int yylex();
void yyerror(char *s);


int dir;
int temporales;
int etiquetas;
int siginst;


%}

%union{
    char sval[32];
    int line;
}

%token <sval> ID
%token REAL ENT 
%token CAR CAD
%token DOUBLE FLOAT INT CHAR STRING STRUCT FUNC PRINT VOID
%token IF SWITCH CASE DEF FOR DO WHILE RETURN BREAK 
%token TR FLS
%token PYC SEP DP
%token LKEY RKEY
%token LBRA RBRA

%left SEPX
%left ASIG

%left OR
%left AND
%left EQUAL NE
%left GT LT GTE LTE
%right NOT

%left ADD SUB
%left MUL DIV MOD
%nonassoc RPAR LPAR

%left FUNCX ARRX PUNTO

%left IFX
%left ELSE


%start program

%%

program : {init();} 
          decl function {
            print_table();            
         };

decl : tipo list_id
      | ;

tipo : INT | FLOAT | DOUBLE | CHAR | VOID | STRUCT LKEY decl RKEY;

list_id : list_id SEP ID tipo_arr | ID tipo_arr;

tipo_arr : LKEY ENT RKEY tipo_arr | ;

function : FUNC tipo ID LPAR def_param RPAR LKEY decl sent RKEY function | ;

def_param : list_param | ;

list_param : list_param SEP tipo ID param_arr %prec SEPX | tipo ID param_arr %prec SEPX;

param_arr : LBRA RBRA param_arr | ;

sent :   sent sent  
		| ID ASIG exp PYC
        | IF LPAR cond RPAR sent %prec IFX
        | IF LPAR cond RPAR sent ELSE sent
		| SWITCH LPAR exp RPAR LKEY casos pred RKEY
		| LKEY sent RKEY
        | PRINT exp
		| FOR LPAR ids ASIG exp PYC cond PYC ids ASIG exp RPAR sent
        | WHILE LPAR cond RPAR sent
		| DO LKEY sent RKEY WHILE LPAR cond RPAR PYC
		| ids ASIG exp PYC
		| RETURN exp PYC
		| RETURN PYC
        | BREAK PYC;
		
casos : CASE DP ENT sent casos | ;

pred : DEF DP sent | ;

ids : ID | arr | ID PUNTO ID;

arr : ID LKEY exp RKEY %prec ARRX | arr LKEY exp RKEY %prec ARRX;

exp :  exp ADD exp 
        | exp SUB exp
        | exp MUL exp
        | exp DIV exp
		| exp MOD exp
		| ids
		| ENT
		| REAL
        | CAR
		| CAD
        | ID LPAR paso_param RPAR %prec FUNCX
        ;

paso_param : paso_param SEP exp | exp;

cond :  cond OR cond
        | cond AND cond 
		| LPAR cond RPAR
        | exp rel exp
		| NOT cond
		| TR
		| FLS
        ;
		

rel : EQUAL 
        | NE
        | GT
		| GTE
        | LT
		| LTE
        ;


        
%%


void yyerror(char* s){
    printf("ERROR:%s, en  la linea %d\n",s, yylval.line);
}



void init(){
    dir = 0;
    temporales = 0;
    etiquetas = 0;
    init_table();
}

int existe(char *id){
    return search(id);
}

int main(int argc, char** argv){
    if(argc>1){
        yyin = fopen(argv[1], "r");
        if(!yyin) return 1;
        yyparse();
        fclose(yyin);
    }
}

