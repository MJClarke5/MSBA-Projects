
reset;

set supplyNodes;
set demandNodes;


param supplyInput{supplyNodes};
param demandMax{demandNodes};
param demandMin{demandNodes};
param MaterialInput{supplyNodes,demandNodes};
param ProductionCost{supplyNodes, demandNodes};
param Price{demandNodes};
var X{supplyNodes, demandNodes} >= 0;




maximize TotalProfit:  
	sum {i in supplyNodes, j in demandNodes} Price[j] - ProductionCost[i,j] * X[i,j];
   
subject to SupConstr {i in supplyNodes}:     
	sum {j in demandNodes} X[i,j]*MaterialInput[i,j] <= supplyInput[i];

subject to DemConstr {j in demandNodes}:     
	sum {i in supplyNodes} X[i,j] <= demandMax[j];

subject to DemMin {j in demandNodes}:     
	sum {i in supplyNodes} X[i,j] <= demandMin[j];