%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>


%}


%%

if                                            { return IF; }
[a-zA-Z_][a-zA-Z0-9_]*                        { yylval.str = strdup(yytext); return ID; }
[1-9][0-9]*                                   { yylval.str = strdup(yytext); return NUMBER; }
[1-9][0-9]*\.[0-9]+                           { yylval.str = strdup(yytext); return NUMBER; }
"=="                                          { yylval.str = strdup(yytext); return COMPARISON; }
">"                                           { yylval.str = strdup(yytext); return COMPARISON; }
"<"                                           { yylval.str = strdup(yytext); return COMPARISON; }
"<="                                          { yylval.str = strdup(yytext); return COMPARISON; }
">="                                          { yylval.str = strdup(yytext); return COMPARISON; }
"!="                                          { yylval.str = strdup(yytext); return COMPARISON; }
"="                                           { return ASSIGN; }
[+-/*]                                        { yylval.str = strdup(yytext); return OPERATOR; }
[ \t]+                                        {  }
\n                                            { return '\n'; }
:                                             { return COLON; }

%%
