package code;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%column
%char
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ ,\t,\r,\n]+
%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

/* Espacios en blanco */
{espacio} {/*Ignore*/}

/* Comentarios */
( "//"(.)* ) {/*Ignore*/}



/* Tipo de dato String */
( String ) {return new Symbol(sym.Cadena, yycolumn, yyline, yytext());}

/* Palabra reservada If */
( if ) {return new Symbol(sym.Reservada, yychar, yycolumn, yytext());}

/* Palabra reservada Else */
( else ) {return new Symbol(sym.Reservada, yycolumn, yyline, yytext());}


/* Identificador */
{L}({L}|{D})* {return new Symbol(sym.Identificador, yycolumn, yyline, yytext());}

/* Numero */
("(-"{D}+")")|{D}+ {return new Symbol(sym.Numero, yycolumn, yyline, yytext());}

/* Error de analisis */
 . {return new Symbol(sym.ERROR, yycolumn, yyline, yytext());}
