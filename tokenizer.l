%{
  #include <stdbool.h>
  #include "tokens.h"
  int line = 1;
  bool boolean = true;
  char v[3];

  typedef struct tok
  {
    char *c;
    int t_number;
    int count;
  }
  tok;

  typedef struct lin
  {
    int ln;
    struct lin *next;
  }
  lin;

  void r_tcount(tok r_t[], int token, lin *la[], int line);
%}

%option noyywrap

%%
"var"          {return 1;}
"integer50"    {return 2;}
"char50"       {return 3;}
"bool50"       {return 4;}
"real50"       {return 5;}
":"            {return 6;}
","            {return 7;}
[a-zA-Z]+      {return 8;}
[0-9]+         {return 9;}
" "+           ;
\n             {line++;}
<<EOF>>        {return 0;}

.              {return 10;}
%%
int main(int argc, char *argv[])
{

tok r_t[tsize];
lin *larr[tsize - 2];

for(int i = 0; i<tsize-2; i++)
larr[i] = NULL;

for(int i=0; i<tsize; i++)
r_t[i].count = 0;

while(true)
{
  printf("do you want specific word and digit layout? (not recomended for huge files) type yes or no\n");
  scanf("%s", v);

  for(int i = 0; v[i] !=0; i++)
  {
    if(i == 3)
    {
    printf("buffer over flow\n");
    return -1;
  }
  }

  if(strcasecmp(v, "yes") == 0 || strcasecmp(v, "no") == 0)
  break;
  else
  printf("wrong input\n");
}

if(argc > 1)
{
  yyin = fopen(argv[1], "r");

  int token = 0;

  if(yyin == NULL)
  {
    printf("error opening file \n");
    return -1;
  }

  while(true)
  {
  token = yylex();

  if(token == 10)
  {
  boolean = false;
  printf("unexpected expression %s in line %i\n", yytext, line);
 }

else if(token == 0 && boolean == false)
{
  return -1;
}

else if(boolean == true)
{
  if (token == 0)
{
  printf("\n");
  for(int i=0; i<(tsize - 2); i++)
  {
  printf("expresion: %s | token number: %i | times: %i | in lines: ", r_t[i].c, i+1, r_t[i].count);
  for(lin *tmp = larr[i]; tmp != NULL; tmp=tmp->next)
  printf("%i ", tmp->ln);
  printf("\n");
}
for(int i=7; i<tsize; i++)
{
printf("%s | token number: %i | times: %i \n", r_t[i].c, i+1, r_t[i].count);
}
  break;
}
  else
  {
  r_tcount(r_t, token, larr, line);

if(strcasecmp(v, "yes") == 0)
{
if(token == tword)
  printf("Found word: %s\n", yytext);
else if(token == tdigit)
  printf("Found digit: %s\n", yytext);
}
}
}
}
  fclose(yyin);
  printf("total lines %i\n", line);
}
else
{
  printf("no input file\n");
  return -1;
}
return 0;
}

void r_tcount(tok r_t[], int token, lin *la[], int line)
{
lin *n = NULL;

if(token == tvar)
{
n=malloc(sizeof(lin));
r_t[token - 1].c = "var";
r_t[token - 1].t_number = 1;
r_t[token - 1].count++;
n->ln = line;
n->next = NULL;

if(la[token - 1] == NULL)
la[token - 1] = n;
else if(la[token - 1] != NULL && la[token - 1]->ln != line)
{
  n->next = la[token - 1];
  la[token - 1] = n;
}
}
else if(token == tinteger)
{
n=malloc(sizeof(lin));
r_t[token - 1].c = "integer50";
r_t[token - 1].t_number = 2;
r_t[token - 1].count++;

n->ln = line;
n->next = NULL;

if(la[token - 1] == NULL)
la[token - 1] = n;
else if(la[token - 1] != NULL && la[token - 1]->ln != line)
{
  n->next = la[token - 1];
  la[token - 1] = n;
}
}
else if(token == tchar)
{
n=malloc(sizeof(lin));
r_t[token - 1].c = "char50";
r_t[token - 1].t_number = 3;
r_t[token - 1].count++;

n->ln = line;
n->next = NULL;

if(la[token - 1] == NULL)
la[token - 1] = n;
else if(la[token - 1] != NULL && la[token - 1]->ln != line)
{
  n->next = la[token - 1];
  la[token - 1] = n;
}
}
else if(token == tboolean)
{
n=malloc(sizeof(lin));
r_t[token - 1].c = "bool50";
r_t[token - 1].t_number = 4;
r_t[token - 1].count++;

n->ln = line;
n->next = NULL;

if(la[token - 1] == NULL)
la[token - 1] = n;
else if(la[token - 1] != NULL && la[token - 1]->ln != line)
{
  n->next = la[token - 1];
  la[token - 1] = n;
}
}
else if(token == treal)
{
n=malloc(sizeof(lin));
r_t[token - 1].c = "real50";
r_t[token - 1].t_number = 5;
r_t[token - 1].count++;

n->ln = line;
n->next = NULL;

if(la[token - 1] == NULL)
la[token - 1] = n;
else if(la[token - 1] != NULL && la[token - 1]->ln != line)
{
  n->next = la[token - 1];
  la[token - 1] = n;
}
}
else if(token == tcolon)
{
n=malloc(sizeof(lin));
r_t[token - 1].c = ":";
r_t[token - 1].t_number = 6;
r_t[token - 1].count++;

n->ln = line;
n->next = NULL;

if(la[token - 1] == NULL)
la[token - 1] = n;
else if(la[token - 1] != NULL && la[token - 1]->ln != line)
{
  n->next = la[token - 1];
  la[token - 1] = n;
}
}
else if(token == tcoma)
{
n=malloc(sizeof(lin));
r_t[token - 1].c = ",";
r_t[token - 1].t_number = 7;
r_t[token - 1].count++;

n->ln = line;
n->next = NULL;

if(la[token - 1] == NULL)
la[token - 1] = n;
else if(la[token - 1] != NULL && la[token - 1]->ln != line)
{
  n->next = la[token - 1];
  la[token - 1] = n;
}
}
else if(token == tword)
{
r_t[token - 1].c = "Words";
r_t[token - 1].t_number = 8;
r_t[token - 1].count++;
}
else if(token == tdigit)
{
r_t[token - 1].c = "Digits";
r_t[token - 1].t_number = 9;
r_t[token - 1].count++;
}
}
