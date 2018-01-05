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
%token NUM
%token INT MAIN PRINT VOID
%token IF WHILE BREAK 
%token PYC
%token LKEY RKEY

%left ASIG
%left OR
%left AND
%left EQUAL NE
%left GT LT
%left ADD SUB
%left MUL DIV
%nonassoc RPAR LPAR
%left IFX
%left ELSE


%start program

%%

program : {init();} 
          decl function {
            print_table();            
         };

         
decl: INT ID PYC {
            if(existe($2)==-1){                
                symbol sym;
                strcpy(sym.id, $2);
                sym.dir = dir;
                sym.type = 1;
                sym.var = 0;
                insert(sym);
                dir+= 4;
            }else{
                yyerror("Identificador duplicado");
            }
    } decl | ;
    

function: VOID MAIN LPAR RPAR LKEY block RKEY;
        
       
block:  sents | ;

sents: sents sent | sent ;

sent:     ID ASIG exp PYC
        | IF LPAR cond RPAR LKEY block RKEY %prec IFX
        | IF LPAR cond RPAR LKEY block RKEY ELSE goto_else LKEY block RKEY
        | PRINT exp
        | WHILE LPAR cond RPAR LKEY block RKEY
        | BREAK PYC;
        
goto_else:;
    

cond :  cond OR cond
        | cond AND cond 
        | exp rel exp 
        ;

rel : EQUAL 
        | NE
        | GT
        | LT
        ;

exp :  exp ADD exp 
        | exp SUB exp
        | exp MUL exp
        | exp DIV exp
        | NUM 
        | ID
        | LPAR exp RPAR
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

