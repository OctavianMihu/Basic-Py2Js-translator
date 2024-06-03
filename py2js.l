%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*                        { yylval.str = strdup(yytext); /*printf("%s\n", "ID");*/ return ID; }
[1-9][0-9]*                                   { yylval.str = strdup(yytext); /*printf("%s\n", "NUMBER");*/ return NUMBER; }
[1-9][0-9]*\.[0-9]+                           { yylval.str = strdup(yytext); /*printf("%s\n", "NUMBER");*/ return NUMBER; }
"=="                                          { yylval.str = strdup(yytext); /*printf("%s\n", "COMPARISON");*/ return COMPARISON; }
">"                                           { yylval.str = strdup(yytext); /*printf("%s\n", "COMPARISON");*/ return COMPARISON; }
"<"                                           { yylval.str = strdup(yytext); /*printf("%s\n", "COMPARISON");*/ return COMPARISON; }
"<="                                          { yylval.str = strdup(yytext); /*printf("%s\n", "COMPARISON");*/ return COMPARISON; }
">="                                          { yylval.str = strdup(yytext); /*printf("%s\n", "COMPARISON");*/ return COMPARISON; }
"!="                                          { yylval.str = strdup(yytext); /*printf("%s\n", "COMPARISON");*/ return COMPARISON; }
"="                                           { /*printf("%s\n", "ASSIGN");*/ return ASSIGN; }
[+-/*]                                        { yylval.str = strdup(yytext); /*printf("%s\n", "OPERATOR");*/ return OPERATOR;}
[ \t]+                                        { /* ignore whitespace */ }
\n                                            { return '\n'; }
.                                             { /* ignore other characters */ }
<<EOF>>                                        { return 0; }
%%
