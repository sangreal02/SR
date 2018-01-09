%{
#include <stdio.h>
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
    char *sval;
    int line;
}

%token REAL ENT 
%token <sval> ID
%token CAR CAD
%token DOUBLE FLOAT INT CHAR STRUCT FUNC VOID
%token IF SWITCH WHILE FOR DO RETURN BREAK PRINT
%token CASE DEF
%token TR FLS
%token PYC SEP DP


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

%nonassoc LBRA RBRA
%left FUNCX ARRX PUNTO 
%token LKEY RKEY
%left IFX OPX
%left ELSE


%start program

%%

program : {init();} 
          decl function {
            print_table();            
         };

decl : tipo list_id PYC
      | ;

tipo : INT | FLOAT | DOUBLE | CHAR | VOID | STRUCT LKEY decl RKEY;

list_id : list_id SEP ID tipo_arr | ID tipo_arr;

tipo_arr : LBRA ENT RBRA tipo_arr | ;

function : FUNC tipo ID LPAR def_param RPAR LKEY decl sent RKEY function | ;

def_param : list_param | ;

list_param : list_param SEP tipo ID param_arr %prec SEPX | tipo ID param_arr %prec SEPX;

param_arr : LBRA RBRA param_arr | ;

sent : sent senti | senti ;
senti : IF LPAR cond RPAR sent PYC %prec IFX
        | IF LPAR cond RPAR sent ELSE sent PYC
		| WHILE LPAR cond RPAR sent PYC
		| DO LKEY sent RKEY WHILE LPAR cond RPAR PYC
		| FOR LPAR ids ASIG exp PYC cond PYC ids ASIG exp RPAR sent PYC
		| ids ASIG exp PYC
		| RETURN exp PYC
		| RETURN PYC
		| LKEY sent RKEY
		| SWITCH LPAR exp RPAR LKEY casos pred RKEY
        | BREAK PYC 
        | PRINT exp;

casos : CASE DP ENT sent casos | ;

pred : DEF DP sent | ;

ids : ID | arr | ID PUNTO ID;

arr : ID LBRA exp RBRA %prec ARRX | arr LBRA exp RBRA %prec ARRX;

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

