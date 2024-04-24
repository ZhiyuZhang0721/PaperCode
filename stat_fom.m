A=xlsread('FoM','B2:G51');
A=A/100;
mean_value=mean(A,1);
std_value=std(A,0,1);
[~,index]=max(A,[],2);
best_value1=length(find(index==1));
best_value2=length(find(index==2));
best_value3=length(find(index==3));
best_value4=length(find(index==4));
best_value5=length(find(index==5));
best_value6=length(find(index==6));

[~,index_min]=min(A,[],2);
worst_value1=length(find(index_min==1));
worst_value2=length(find(index_min==2));
worst_value3=length(find(index_min==3));
worst_value4=length(find(index_min==4));
worst_value5=length(find(index_min==5));
worst_value6=length(find(index_min==6));

best=[best_value1 best_value2 best_value3 best_value4 best_value5 best_value6]
worst=[worst_value1 worst_value2 worst_value3 worst_value4 worst_value5 worst_value6]

x=1:1:50;
plot(x,A(:,1),'-*',x,A(:,3),'-s')