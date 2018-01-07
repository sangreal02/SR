/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SYNTAXIS_TAB_H_INCLUDED
# define YY_YY_SYNTAXIS_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    REAL = 259,
    ENT = 260,
    CAR = 261,
    CAD = 262,
    DOUBLE = 263,
    FLOAT = 264,
    INT = 265,
    CHAR = 266,
    STRING = 267,
    STRUCT = 268,
    FUNC = 269,
    PRINT = 270,
    VOID = 271,
    IF = 272,
    SWITCH = 273,
    CASE = 274,
    DEF = 275,
    FOR = 276,
    DO = 277,
    WHILE = 278,
    RETURN = 279,
    BREAK = 280,
    TR = 281,
    FLS = 282,
    PYC = 283,
    SEP = 284,
    DP = 285,
    LKEY = 286,
    RKEY = 287,
    LBRA = 288,
    RBRA = 289,
    SEPX = 290,
    ASIG = 291,
    OR = 292,
    AND = 293,
    EQUAL = 294,
    NE = 295,
    GT = 296,
    LT = 297,
    GTE = 298,
    LTE = 299,
    NOT = 300,
    ADD = 301,
    SUB = 302,
    MUL = 303,
    DIV = 304,
    MOD = 305,
    RPAR = 306,
    LPAR = 307,
    FUNCX = 308,
    ARRX = 309,
    PUNTO = 310,
    IFX = 311,
    ELSE = 312
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 19 "syntaxis.y" /* yacc.c:1909  */

    char sval[32];
    int line;

#line 117 "syntaxis.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SYNTAXIS_TAB_H_INCLUDED  */
