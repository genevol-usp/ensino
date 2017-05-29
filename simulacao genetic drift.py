# -*- coding: utf-8 -*-
"""
Created on Sat May 27 17:35:37 2017

@author: alan barzilay
"""

#import numpy
import matplotlib.pyplot as plt
import random
import matplotlib.animation as animation

#import matplotlib.lines as mlines   # para por legendas (?)
 

def genetic_drift(N, p0):
    
    G = 100  #colocar ocmo input da funcao?  #numero de geracoes q vamos deixar a simulacao correr
    i=0
    pop_atual = []
    geracoes = []
    frequencias = []

    
    
    
    while (i<2*N): # da pra melhorar isso facil #criar lista de tamanho 2N com proporcao certa de alelos
    
        if (i <2*N*p0):
            pop_atual.append(1) #alelo de frequencia p0
        else:
            pop_atual.append(0)  #outro alelo
            
        i+=1
        
   
        
   #random.shuffle(pop_atual) # mistura populacao (n sei se precisa, to achando q nao)
    
    
    
    
    geracoes.append( pop_atual)  # faz as seguintes iteracoes para cada geracao
    i=1
    while (i<= G):
     
        geracoes.append( random.choices( geracoes[i-1] , k = 2*N))
        #seleciona elementos de maneira aleatoria da geracao passada ate terminar de compor a nova geracao, assim cada geracao eh salva e feita a partir da anterior       
        i+=1
        
#    i=0
#    while ( i < len(geracoes)):
#        print (geracoes[i])
#        i+=1

    i=1
    frequencias.append( p0)
    while (i < len(geracoes)): 
      
        p_i = 0
        j=0
        while(j  < 2*N):
        
            p_i += geracoes[i][j]
            j+=1
            
        p_i = p_i/(2*N) #numero de alelos A1 dividido pelo numero total de alelos
        frequencias.append( p_i )
        i+=1
  
        
        
  
    return frequencias

def heterozigose(frequencias):
    #dado uma lista de frequencias, gera uma lista com a heterozigose de cada frequencia
    heterozigose = []
    i=0
    while (i < len(frequencias)):
        heterozigose.append(  2 * frequencias[i] *( 1 - frequencias[i] ))
        
        i+=1
    return heterozigose



    
    
    
teste = genetic_drift(20, 0.2) 

plt.plot( range(len(teste)) , teste, label = "Frequencia(t)")
plt.plot( range(len(teste)) , heterozigose(teste), label = "Heterozigose(t)")

plt.xlim( [0, 102])#definir limites do grafico
plt.ylim([0,1])#definir limites do grafico
plt.legend()#handles=[red_line, blue_line]) #definir legenda
plt.xlabel("Gerações")
plt.ylabel("p")
#plt.title("TITULO")   #ponho titulo?


#outro jeito de fazer legenda:
#red_line = mlines.Line2D([], [], color='red', markersize=15, label="[B]")
#blue_line = mlines.Line2D([], [], color='blue', markersize=15, label="[A]")


#
#fig1 = plt.figure()
#
#teste_gif = animation.FuncAnimation(fig1, genetic_drift, 25,fargs = (20 , 0.2) , interval=50)    
#    
plt.show
