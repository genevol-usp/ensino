# -*- coding: utf-8 -*-
"""
Created on Sat Jun 10 21:46:08 2017

@author: Alberto
"""
#import numpy
import matplotlib.pyplot as plt
import random
#import matplotlib.animation as animation
import statistics


def heterozigose_mutacao_deriva(N,u, G):
    
    populacao = [0] *2*N
    geracoes = []
    cont = 0 
    geracoes.append(populacao)
    heterozigose = []
    
    
    
    i=1
    while (i<= G):
     
        geracoes.append( random.choices( geracoes[i-1] , k = 2*N))
        #seleciona elementos de maneira aleatoria da geracao passada ate terminar de compor a nova geracao, assim cada geracao eh salva e feita a partir da anterior       
        
        
        
        j=0
        while( j < 2*N ):
            #print (j, " j")
            if (17 == random.randrange(u) ):
                cont+=1
                geracoes[i][j] = cont
        
            j+=1
            
            
        heterozigose.append(contagem(geracoes[i], cont))
        
       
        i+=1 
        
        
        
    plt.plot( range(len(heterozigose)) , heterozigose, label = "Heterozigose(t)")
    
    
#    plt.xlim( [0, G])#definir limites do grafico
#    plt.ylim([0,1])#definir limites do grafico
#    plt.legend()#handles=[red_line, blue_line]) #definir legenda
#    plt.xlabel("Gerações")
#    plt.ylabel("Heterozigose")
#    
    
    plt.show
    
    return


                    
    
                
                
                
    

def contagem(alelos, cont):
    
    frequencias = [0] * (cont + 1)
    
    
    for i in range( len( alelos)):
        
        frequencias[ alelos[i] ] += 1
        
     
    for i in range(len(frequencias )):
        frequencias[i] = frequencias[i] / (len(alelos))
        
    heterozigose = 1    
    i = 0
    while (i< cont+1):
        heterozigose -= frequencias[i]*frequencias[i] 
    
        i+=1
    
    
    
    return heterozigose






def hetero_teorico_mut(N,u,G,H0):
    
    
    heterozigose = [H0]
    hetero_deriva = []
    hetero_mutacao = []
    H =[]
    
    i=1
    while (i < G):
        delta_deriva = (heterozigose[i-1] / (2*N) )
        hetero_deriva.append(delta_deriva)
        print(delta_deriva, " delta deriva " )
        
        delta_mutacao = ( 2 * u * (1 - heterozigose[i-1] ) )
        hetero_mutacao.append(delta_mutacao)
        print(delta_mutacao, " delta mutacao ")
        
        delta_H =  delta_mutacao - delta_deriva
        H.append(delta_H)
        print(delta_H , "delta H")
        
        heterozigose.append(heterozigose[i-1] + delta_H)
        print(heterozigose[i] , "heterozigose")
        
        i+=1
    
    #plt.plot( range(len(heterozigose)) , heterozigose, label = "Heterozigose teorica(t)")
    
    plt.plot( range(len(hetero_deriva)) , hetero_deriva, label = "Delta Heterozigose deriva(t)")
    
    plt.plot( range(len(hetero_mutacao)) , hetero_mutacao, label = "Delta Heterozigose mutacao(t)")
    
    plt.plot( range(len(H)) , H, label = "Delta H(t)")
    
    
    plt.xlim( [0, G])#definir limites do grafico
    plt.ylim([0,0.02])#definir limites do grafico
    plt.legend()#handles=[red_line, blue_line]) #definir legenda
    plt.xlabel("Gerações")
    plt.ylabel("Heterozigose")
    
    
    plt.show
    
    
    return








hetero_teorico_mut(100,0.01,200, 0)













#heterozigose_mutacao_deriva(1000,1000, 100)






