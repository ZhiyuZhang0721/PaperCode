function ret=Mutation(pmutation,chrom,sizepop,length1)
%变异操作
%pmutation      input      变异概率
%chrom          input      抗体群
%sizepop        input      种群规模
%iii            input      进化代数
%MAXGEN         input      最大进化代数
%length1        input      抗体长度
%ret            output     变异得到的抗体群
for i=1:sizepop
    %变异概率
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=unidrnd(sizepop);
    %判断是否变异
    if pick>pmutation
        continue;
    end
    pos=unidrnd(length1);
    while pos==1
        pos=unidrnd(length1);
    end
    nchrom=chrom(index,:);
    nchrom(pos)=unidrnd(31);
    while length(unique(nchrom))==(length1-1)
          nchrom(pos)=unidrnd(31);
    end
    flag=0;
    if fitness(nchrom)<fitness(chrom(index,:))
        flag=1;
    end
    if flag==1
        chrom(index,:)=nchrom;
    end
end
ret=chrom;
end
        
        
        
