# -*- coding: utf-8 -*-
"""
Created on Mon Jul  3 23:33:16 2017

@author: Alberto
"""
import matplotlib.pyplot as plt



def deltas(N, u):
    
 
    H = range(0,1000)
    
    H_deriva =[]
    H_mutacao = []
    i=0
    achei = "deu ruim"
    for j in H:
        
    
        del_deriva = H[i] / (2*N*1000)
        del_mutacao = 2*u* (1 - ( H[i]/1000) )
        H_deriva.append(del_deriva)
        H_mutacao.append(del_mutacao)
        if del_deriva == del_mutacao:
            achei = del_deriva
        i+=1
        
        
    plt.plot(range(len(H_deriva)) , H_deriva, label = "Delta H Deriva ")
    plt.plot(range(len(H_mutacao)) , H_mutacao, label = "Delta H Mutação ")
    
    plt.legend()
    plt.show
          
    #print(achei, "= H de equilibrio") #deu ruim pq a precisão n eh suficiente pra ele reconhecer o ponto certo
    
    return 
        
    
deltas(10000 , 0.00005)




