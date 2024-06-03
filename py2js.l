%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*    { yylval.str = strdup(yytext); return ID; }
[1-9][0-9]*               { yylval.str = strdup(yytext); return NUMBER; }
[1-9][0-9]*\.[0-9]+       { yylval.str = strdup(yytext); return NUMBER; }
"="                       { return ASSIGN; }
[ \t]+                    { /* ignore whitespace */ }
\n                        { return '\n'; }
.                         { /* ignore other characters */ }
<<EOF>>                   { return 0; }
%%
