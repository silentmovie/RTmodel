# RTmodel
A computational model to simulate two-phase Euler fluids mixing phenomenon by Rayleigh-Taylor instability.

This project is a follow-up to the paper [RT2017](https://arxiv.org/abs/1605.04259) by R. Granero-Belinchón and S. Shkoller. In their paper, they derive an asymptotic model for the motion of multiphase incompressible Euler flows in 2D, subjected to Rayleigh-Taylor(RT) instability, allowing turn-over.

To simulate the mixing phenomenon caused by RT even for immiscible fluids without diffusion (See [DAMTP](https://www.youtube.com/watch?v=NI85oC-3mJ0) by Megan S. Davies Wykes and Stuart B. Dalziel), we add the Gaussian noise on initial data of the interface and do an ensemble averaging procedure to formulate the mixing problem.

To see how to measure mixedness without diffusion, see [Mix_Norm](https://arxiv.org/abs/1105.1101) by Jean-Luc Thiffeault

## The output of the code:
1. A movie consists of 
   a) a figure that illuminates the overall mixing phenomenon
   b) a figure that focuses on how well fluids mix in any interested window
   c) a figure that quantifies how well fluids mix in the interested window
   d) a figure that tracks the effect of artificial viscosity
2. A movie that illuminates the motion of interface
3. Recorded data like the evolution of density.

![RT Mixing](https://github.com/silentmovie/RTmodel/blob/master/sample%20output/movie6.png)
