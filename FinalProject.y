%{
    #include <stdio.h>
    #include <math.h>
    #define YYSTYPE int	
    extern FILE *yyin;
    extern FILE *yyout;
    int temp[1000] ;
    int check[1000]={0};
    int yylex(); 
    void yyerror (char const *s); 
   
    
%}


%token NUM VAR IF ELSE MAIN INT CHAR FLOAT FOR DO WHILE POWER REAL THEN MUL SQUARE ROOT
%nonassoc IF
%nonassoc ELSE
%left '<' '>'
%left '+' '-'
%left '*' '/'

%start program

%%
program:
	| MAIN '{' in_main '}'	{ printf("inside main fun\n");}
       ;
in_main:
    |in_main  statement
    ;



statement : '#'
        | begin {}
		|condition '#'   {printf("valid work\n");}
		|VAR ':' condition '#'	{printf("assignment\n");}
		|IF '(' condition ')' '{' statement  '}' {if($3) printf("In if %d\n",$6); }  
        |IF '(' condition ')'  '{' statement '}'  ELSE  '{'  statement '}'  {if($3) printf("if condition is true %d\n",$6);
						 else 
						 printf("else condition is true  %d\n",$8);}	


        |FOR '(' NUM ':' NUM ':' NUM ')'  '{' statement '}'{ 
                                          int x,y;
										  y=$7;
										  printf("for loop\n");
                                        for(x=$3;x<=$5;x+=y)
                                               { 
 											   printf("%d\n",$10);
											   }
											   
											   }
	
	   |  WHILE '(' NUM '@' NUM  ')'    '{' statement '}' {
				                    printf("while loop\n");
				                        int z,w;
					                  z=$3;
					                 w=$5;
					                     while(z<=w)
					                            {
					                    printf("%d\n",$8);
					                          z++;
					
					
					                             }
					
				}
		| MUL '(' NUM ',' NUM ')'  '#' { int x=$3;
		                             int y=$5;
									 printf("the multiplicaiton is : %d\n",x*y);
									 }
		| SQUARE '(' NUM ')' '#' { int x=$3;
		                         printf("the square is : %d\n",x*x);
								 }
		
        | ROOT '(' NUM ')' '#' {  int x=$3;
                                     x=sqrt(x);
                              printf("the root is :%d\n",x);  
                              }							  
		 ;
	
condition : NUM	{$$ = $1 ;}	
            | VAR	{$$ = temp[$1];}
			    
	        | condition '+' condition 	{$$ = $1 + $3 ;}
	        | condition '-' condition 	{$$ = $1 - $3 ;}
	        | condition '*' condition 	{$$ = $1 * $3 ;}
	        | condition '/' condition 	{ if($3) $$ = $1 / $3 ;
					  else { $$ = 0 ; printf("\nDivision by zero\n") ;} }
	        | condition '<' condition 	{$$ = $1 < $3 ;}
	        | condition '>' condition 	{$$ = $1 > $3 ;}
	        | '(' condition ')'	{$$ = $2;}
			
            ;
		
		
begin : TYPE ID1 '#' {
                               printf("\nValid Declaration\n");
                           }
             ;


TYPE : INT  {}
     | FLOAT  {}
     | CHAR  {}
	 |REAL	{}
     ;



ID1 : ID1 ',' VAR  {
                    if(check[$3]==0)
                    { check[$3]++;} 
                    else
                    { printf("invalid  declaration\n");} 
                   }
    |VAR          {if(check[$1]==0)
                    { check[$1]++;}
                   else
                    { printf("invalid declaration\n");}
                    }
    ;
	



%%


int main()
{
	printf("GO TO START ");
        yyin=freopen("input.txt","r",stdin);
        yyout=freopen("out.txt","w",stdout);
	yyparse();
	return 0;
}


void yyerror (char const *s)
{
	fprintf (stderr, "%s\n", s);
}

int yywrap()
{
	return 1;
}