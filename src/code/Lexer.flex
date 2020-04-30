package code;
import java.io.*;
import static code.Tokens.*;

%%
%class Lexer
%type Tokens
%line
%column
%ignorecase



L=[a-zA-Z_-]+
D=[0-9]+
T=[0-9]+
ND=[0-9]+(\.[0-9]+)?
Comillas=[a-zA-Z]?

LineTerminator = \r|\n|\r\n
espacio= {LineTerminator} | [ \t\f]

%{
    public String lexeme;
    public String cadena;
    public int line;
    public int column;
    StringBuffer string = new StringBuffer();

%}

%state STRING
%state PROCESS 
%state FUNCTION
%state STRINGC
%state COMMENT


%%

<YYINITIAL>{
"/*".* {/*Ignore*/}
if |
else |
while { line=yyline; column=yycolumn; lexeme="descripcion"; cadena=yytext(); return Reservada;}

"procedimiento" { line=yyline; column=yycolumn; lexeme="Instruccion de procedimiento"; cadena=yytext(); return Reservada; }
"funcion" { line=yyline; column=yycolumn; lexeme="Instruccion de funcion"; cadena=yytext(); return Reservada; }
"arreglo" { line=yyline; column=yycolumn; lexeme="Instruccion de arreglo"; cadena=yytext(); return Reservada; }
"registro" { line=yyline; column=yycolumn; lexeme="Instruccion inicial de registro"; cadena=yytext(); return Reservada; }
"fin registro" { line=yyline; column=yycolumn; lexeme="Sentencia final de un registro"; cadena=yytext(); return Reservada; }

/**
* Reservadas
*/
inicio {line=yyline; column=yycolumn; lexeme="Sentencia de inicio"; cadena=yytext(); return Reservada;}
escriba {line=yyline; column=yycolumn; lexeme="Escribe un texto"; cadena=yytext(); return Reservada;}
lea {line=yyline; column=yycolumn; lexeme="Lee una variable"; cadena=yytext(); return Reservada;}
fin {line=yyline; column=yycolumn; lexeme="Sentencia de fin"; cadena=yytext(); return Reservada;}
llamar {line=yyline; column=yycolumn; lexeme="Palabra reservada para llamar un procedimiento"; cadena=yytext(); return Reservada;}
si {line=yyline; column=yycolumn; lexeme="Sentencia de condicion"; cadena=yytext(); return Reservada;}
entonces {line=yyline; column=yycolumn; lexeme="Entonces"; cadena=yytext(); return Reservada;}
sino {line=yyline; column=yycolumn; lexeme="Sentencia de lo contrario"; cadena=yytext(); return Reservada;}
"fin si" {line=yyline; column=yycolumn; lexeme="Sentencia final de condicion"; cadena=yytext(); return Reservada;}
caso {line=yyline; column=yycolumn; lexeme="Instruccion inicial de la estructura caso"; cadena=yytext(); return Reservada;}
"fin caso"  {line=yyline; column=yycolumn; lexeme="Instruccion final de la estructura caso"; cadena=yytext(); return Reservada;}
mientras  {line=yyline; column=yycolumn; lexeme="Instruccion inicial del bucle mientras"; cadena=yytext(); return Reservada;}
haga  {line=yyline; column=yycolumn; lexeme="Instruccion haga del bucle"; cadena=yytext(); return Reservada;}
"fin mientras"  {line=yyline; column=yycolumn; lexeme="Instruccion final del bucle mientras"; cadena=yytext(); return Reservada;}
para {line=yyline; column=yycolumn; lexeme="Instruccion inicial del bucle para"; cadena=yytext(); return Reservada;}
hasta {line=yyline; column=yycolumn; lexeme="Instruccion hasta del bucle"; cadena=yytext(); return Reservada;}
"fin para" {line=yyline; column=yycolumn; lexeme="Instruccion finial del bucle mientras"; cadena=yytext(); return Reservada;}
repita {line=yyline; column=yycolumn; lexeme="Instruccion inicial del bucle repita"; cadena=yytext(); return Reservada;}
var {line=yyline; column=yycolumn; lexeme="Indica que la variable es un parametro de referencia o variable"; cadena=yytext(); return Reservada;}
Retorne {line=yyline; column=yycolumn; lexeme="Devuelve el valor de la funcion"; cadena=yytext(); return Reservada;}
de {line=yyline; column=yycolumn; lexeme="sentencia de"; cadena=yytext(); return Reservada;}

/**
* Tipos de Dato
*/
Entero {line=yyline; column=yycolumn; lexeme="Tipo de dato - Solo números enteros"; cadena=yytext(); return Reservada;}
Real {line=yyline; column=yycolumn; lexeme="Tipo de dato - Números con cifras decimales"; cadena=yytext(); return Reservada;}
Caracter {line=yyline; column=yycolumn; lexeme="Tipo de dato - Cuando queremos guardar un solo carácter"; cadena=yytext(); return Reservada;}
Booleano  {line=yyline; column=yycolumn; lexeme="Tipo de dato - Cuando necesitamos guardar una expresión lógica (verdadero o falso) "; cadena=yytext(); return Reservada;}
Cadena {line=yyline; column=yycolumn; lexeme="Tipo de dato - Cuando queremos guardar letras "; cadena=yytext(); return Reservada;}


/**
* Operadores
*/
"(" {line=yyline; column=yycolumn; lexeme="Parentesis de apertura"; cadena=yytext(); return CaracterEspecial;}
")" {line=yyline; column=yycolumn; lexeme="Parentesis de cierre"; cadena=yytext(); return CaracterEspecial;}
"mod" {line=yyline; column=yycolumn; lexeme="Operador de cáculo de residuo"; cadena=yytext(); return Operador;}
"div" {line=yyline; column=yycolumn; lexeme="Operador de división entera "; cadena=yytext(); return Operador;}
"y" {line=yyline; column=yycolumn; lexeme="Operador de lógica Y"; cadena=yytext(); return Operador;}
"o" {line=yyline; column=yycolumn; lexeme="Operador de lógica O"; cadena=yytext(); return Operador;}
"=" {line=yyline; column=yycolumn; lexeme="Operador de comparacion"; cadena=yytext(); return Operador;}
">" {line=yyline; column=yycolumn; lexeme="Mayor que"; cadena=yytext(); return Operador;}
">=" {line=yyline; column=yycolumn; lexeme="Mayor o igual que"; cadena=yytext(); return Operador;}
"<" {line=yyline; column=yycolumn; lexeme="Menor que"; cadena=yytext(); return Operador;}
"<=" {line=yyline; column=yycolumn; lexeme="Menor o igual que"; cadena=yytext(); return Operador;}
"<>" {line=yyline; column=yycolumn; lexeme="Diferente de"; cadena=yytext(); return Operador;}
"←" {line=yyline; column=yycolumn; lexeme="Operador de asignacion de valor de variables"; cadena=yytext();return Operador;}
"<-" {line=yyline; column=yycolumn; lexeme="Operador de asignacion de valor de variables"; cadena=yytext();return Operador;}



/**
* Procedimientos
*/
nueva_linea {line=yyline; column=yycolumn; lexeme="Instruccion que realiza un salto de linea"; cadena=yytext(); return Identificador;}

/**
* CaracterEspecial
*/


"[" {line=yyline; column=yycolumn; lexeme="Corchete de Apertura"; cadena=yytext(); return CaracterEspecial;}
"]" {line=yyline; column=yycolumn; lexeme="Corchete de Cierre"; cadena=yytext(); return CaracterEspecial;}
"," {line=yyline; column=yycolumn; lexeme="Coma simple"; cadena=yytext(); return CaracterEspecial;}
"%" {line=yyline; column=yycolumn; lexeme="Simbolo de porcentaje"; cadena=yytext(); return CaracterEspecial;}
"." {line=yyline; column=yycolumn; lexeme="Punto"; cadena=yytext(); return CaracterEspecial;}
":" {line=yyline; column=yycolumn; lexeme="Dos puntos"; cadena=yytext(); return CaracterEspecial;}

/**
* Texto
*/


   
{espacio} {/*Ignore*/}
"//".* {/*Ignore*/}
"=" {line=yyline; column=yycolumn; lexeme="Operador de asignacion"; cadena=yytext();return Igual;}
"+" {line=yyline; column=yycolumn; lexeme="Operador de suma"; cadena=yytext();return Suma;}
"-" {line=yyline; column=yycolumn; lexeme="Operador de resta"; cadena=yytext();return Resta;}
"*" {line=yyline; column=yycolumn; lexeme="Operador de multiplicacion"; cadena=yytext();return Multiplicacion;}
"/" {line=yyline; column=yycolumn; lexeme="operador de division"; cadena=yytext();return Division;}
{L}({L}|{D})* {line=yyline; column=yycolumn; lexeme="Identificador"; cadena=yytext(); return Identificador;}
("(-"{D}+")")|{D}+ {line=yyline; column=yycolumn; lexeme="Numero Entero"; cadena=yytext(); return Numero;}
{D}?"."{D}* {line=yyline; column=yycolumn; lexeme="Numero Decimal"; cadena=yytext(); return Numero;}

\"  { string.setLength(0); yybegin(STRING); line=yyline; column=yycolumn; lexeme="Comillas Dobles"; cadena=yytext(); return CaracterEspecial; }
\'  { string.setLength(0); yybegin(STRINGC); line=yyline; column=yycolumn; lexeme="Comillas Simples"; cadena=yytext(); return CaracterEspecial; }
\*  { string.setLength(0); yybegin(COMMENT); line=yyline; column=yycolumn; lexeme="Inicio Comentario"; cadena=yytext(); return CaracterEspecial; }
}

<STRING> {
[^\n\r\"\\]+ { string.append(yytext()); line=yyline; column=yycolumn; lexeme="Cadena";  cadena=string.toString(); return Cadena; }

\"  { yybegin(YYINITIAL); line=yyline; column=yycolumn; lexeme="Comillas Dobles"; cadena=yytext(); return CaracterEspecial; }

\'  { yybegin(YYINITIAL); line=yyline; column=yycolumn; lexeme="Comillas Simples"; cadena=yytext(); return CaracterEspecial; }
}

<STRINGC> {
Comillas {string.append(yytext()); line=yyline; column=yycolumn; lexeme="Cadena";  cadena=string.toString(); return Cadena; }
\'  { yybegin(YYINITIAL); line=yyline; column=yycolumn; lexeme="Comillas Simples"; cadena=yytext(); return CaracterEspecial; }
}


<PROCESS> {
{espacio} {/*Ignore*/}
"//".* {/*Ignore*/}
{L}({L}|{D})* { yybegin(YYINITIAL); line=yyline; column=yycolumn; lexeme="Nombre del procedimiento"; cadena=yytext(); return Identificador;}
}

<COMMENT>{
 [^\n\r\"\\]+ {/*Ignore*/}
}



 . {line=yyline; column=yycolumn; lexeme="Simbolo no definido"; cadena=yytext(); return ERROR;}


