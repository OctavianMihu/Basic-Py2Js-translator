%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

extern int yylex();
extern int yyparse();
void yyerror(const char *s);

typedef struct {
    char *str;
} YYSTYPE;

#define YYSTYPE_IS_DECLARED 1

typedef struct Symbol {
    char *name;
    struct Symbol *next;
} Symbol;

Symbol *symbolTable = NULL;

bool addSymbol(const char *name) {
    Symbol *current = symbolTable;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return false; // Symbol already exists
        }
        current = current->next;
    }
    Symbol *newSymbol = (Symbol *)malloc(sizeof(Symbol));
    newSymbol->name = strdup(name);
    newSymbol->next = symbolTable;
    symbolTable = newSymbol;
    return true;
}

bool isSymbol(const char *name) {
    Symbol *current = symbolTable;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            return true; // Symbol exists
        }
        current = current->next;
    }
    return false;
}

%}

%union {
    char *str;
}

%token <str> ID NUMBER ASSIGN

%%
input:
    /* empty */
    | input line
    ;

line:
    r '\n'
    | '\n'
    ;

r: ID ASSIGN NUMBER {
        if (!addSymbol($1)) {
            printf("%s = %s;\n", $1, $3);
        } else {
            printf("let %s = %s;\n", $1, $3);
        }
        free($1);
        free($3);
    }
 | ID ASSIGN ID {
        if (!isSymbol($3)) {
            yyerror("Undeclared variable on the right-hand side");
        } else {
            if (!addSymbol($1)) {
                printf("%s = %s;\n", $1, $3);
            } else {
                printf("let %s = %s;\n", $1, $3);
            }
        }
        free($1);
        free($3);
    }
  | ID ASSIGN ID '+' ID
 ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char *argv[]) {
    yyparse();
    return 0;
}

int yywrap() {
    return 1;
}
