/* C Declarations */

%{
	#include<stdio.h>
	#include <math.h>
	int sym[26],store[26];
%}


%token jodi othoba inc jonno jokhon thamo NUM VAR INT FLOAT CHAR left_B right_B left_SB right_SB darao jog biug gun vag ASSIGN GT LT GTequal LTequal start end POW


/* Simple grammar rules */

%%

cstatement: /* empty */

	| cstatement statement
	
	| cdeclaration
	;
	
cdeclaration:	TYPE ID1 thamo	{ printf("\nvalid declaration\n"); }
			;
			
TYPE : INT

     | FLOAT

     | CHAR
     ;


ID1  : ID1 darao VAR	{
				if(store[$3]==1)
                           {
                              char ch;
                              ch = $3 + 'a';
                           printf("%c is already declared\n",ch);
                           }
              else 
                   {
                     store[$3]=1;
                   }
			}

     |VAR	{
     		if(store[$1]==1)
                           {
                             char ch;
                              ch = $1 + 'a';
                           printf("%c is already declared\n",ch);
                           }
              else 
                   {
                     store[$1]=1;
                   }
				
			}
     ;
     


statement: thamo

	| expression thamo 			{ printf("\nvalue of expression: %d\n", $1); }

        | VAR ASSIGN expression thamo 		{ 
							sym[$1] = $3; 
							printf("\nValue of the variable: %d\t\n",$3);
						}

	;

	| jodi expression thamo start expression end {
								if($2)
								{
									printf("\nvalue of expression in jodi: %d\n",$5);
								}
								else
								{
									printf("\ncondition value zero in jodi block\n");
								}
							}

	| jodi expression thamo start expression end othoba start expression end {
								 	if($2)
									{
										printf("\nvalue of expression in jodi: %d\n",$5);
									}
									else
									{
										printf("\nvalue of expression in othoba: %d\n",$9);
									}
								   }


	| jodi expression thamo start jodi expression thamo start expression end othoba start expression end end 
	othoba start expression end{
								 	if($2)
									{
										if($6)
										printf("\nvalue of expression middle jodi: %d\n",$9);
										else
										printf("\nvalue of expression middle othoba: %d\n",$13);
									}
									else
									{
										printf("\nvalue of expression in else: %d\n",$18);
									}
								   }


	| jonno left_SB VAR ASSIGN NUM darao VAR LTequal NUM darao VAR inc right_SB start statement end {
																				printf("\nIn Loop:\n");
																				int i;
																				for( sym[$3]=$5; sym[$3] <= $9; sym[$3]++)
																					{
																						printf("%d",$15);
																						printf("\n");

																						
																					}printf("\n");
																				
																				}		   
	

	| jokhon left_SB VAR LTequal NUM right_SB start statement VAR inc end {

		while(sym[$3]<=$5){

			printf("expression in while loop : %d\n",$8);
			
			sym[$3]++;
		}

	}

	| expression jog expression	{ $$ = $1 + $3; printf("\nvalue of expression in Jog: %d\n",$$);}

	| expression biug expression { $$ = $1 - $3; printf("\nvalue of expression in Biug: %d\n",$$);}

	| expression gun expression	{ $$ = $1 * $3; printf("\nvalue of expression in Gun: %d\n",$$);}

	| expression vag expression	{ 	if($3) 
				  		{
				     			$$ = $1 / $3;
				     			printf("\nvalue of expression in Vag: %d\n",$$);
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		} 	
				    	}
	| expression POW expression { $$=pow($1,$3); printf("\nTo the power value: %d\n",$$); }

	| NUM{
					     
			if($1%2 == 0)
				{
					 printf("\nEVEN NUMBER\n"); 
				}					       
					  else printf("\nODD NUMBER\n"); 
		                   
					}


	;

expression: NUM				{ $$ = $1; 	}

	| VAR				{ $$ = sym[$1]; }

	| expression LT expression	{ $$ = $1 < $3; }

	| expression GT expression	{ $$ = $1 > $3; }

	| expression GTequal expression  { $$ = $1 >= $3; }
       
    | expression LTequal expression     { $$ = $1 <= $3; }

	| left_B expression right_B		{ $$ = $2;	}
	;
%%

int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}

