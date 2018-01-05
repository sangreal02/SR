%{
	#include <stdio.h>
	#include "attribs.h"

	void yyerror(char* s);
%}

%union{
	num nval;
}

%left MAS
%left MUL
%nonassoc LPAR RPAR
%token <nval> ENT
%token <nval> REAL

%type <nval> line exp term factor

%start line 

%%
	line: exp{
				if($$.tipo == 1){
					printf("%d\n", $1.ival);
				}else{
					printf("%f\n", $1.dval);
				}
			};

	exp: exp MAS term{
				if($1.tipo == $3.tipo){
					$$.tipo = $1.tipo;
					if($$.tipo == 1){
						$$.ival = $1.ival + $3.ival;
					}else{
						$$.dval = $1.dval + $3.dval;
					}			
				}else{
					yyerror("Error semantico");
				}
				//$$=$1+$3;
			}|term{$$=$1;};
	
	term: term MUL factor{
							if($1.tipo == $3.tipo){
								$$.tipo = $1.tipo;
								if($$.tipo == 1){
									$$.ival = $1.ival * $3.ival;
								}else{
									$$.dval = $1.dval * $3.dval;
								}			
							}else{
								yyerror("Error semantico");
							}							
							//$$=$1*$3;
						}|factor{$$=$1;};
	
	factor: ENT {$$=$1;}| REAL {$$=$1;}| LPAR exp RPAR{$$=$2;};
	
%%

extern FILE *yyin;

int main(int argc, char** argv){
    if(argc>1){
        yyin = fopen(argv[1], "r");
        if(!yyin) return 1;
        yyparse();
        fclose(yyin);
    }
}

void yyerror(char* s)
{
	printf("%s\n",s);
}
