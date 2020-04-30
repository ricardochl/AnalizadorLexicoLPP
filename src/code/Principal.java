/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package code;

import java.io.File;

/**
 *
 * @author ricardochavarria
 */
public class Principal {
    public static void main(String[] args) {
        String route = "/Users/Ricardo Chavarria/Documents/NetBeansProjects/AnalizadoLexicoLPP/src/code/Lexer.flex";
        //String route2 = "/Users/Ricardo Chavarria/Documents/NetBeansProjects/AnalizadoLexicoLPP/src/code/LexerCup.flex";
        generarLexer(route);
    }
    
    public static void generarLexer(String route){
        File file;
        file = new File(route);
        jflex.Main.generate(file);
        
        //file = new File(route2);
        //jflex.Main.generate(file);
    }
}
