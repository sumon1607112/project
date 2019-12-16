%{
	#include <stdio.h>
	#include "FinalProject.tab.h"
        extern int yylval;
     
%}


%%

[ \t]+
"\n"
"int"  return(INT);
"char" return(CHAR);
"float" return(FLOAT);
"real"	return(REAL);
"if" {return IF ;}
"else"	{return ELSE ;}
"then"	{return THEN ;}
"for"	{return FOR ;}
"while"	{return WHILE ;}
"mul"	{return MUL ;}
"square"	{return SQUARE ;}
"root"	{return ROOT ;}

"void main()"	{return MAIN ;}

[0-9]+ {yylval = atoi(yytext) ; return NUM ;}

[a-z] { yylval = *yytext - 'a' ; return VAR ; }

[-+/*<>=,(){};#:@] {yylval = yytext[0] ; return *yytext ;}
.   {printf("\nunknown character");}




%%





