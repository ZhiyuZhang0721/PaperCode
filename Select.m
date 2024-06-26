function ret=Select(individuals,sizepop)
%轮盘赌选择
%individuals     input     种群
%sizepop         input     种群规模
%ret             output    选择后得到的种群
excellence=1-individuals.excellence;
pselect=excellence./sum(excellence);  
index=[];
for i=1:sizepop
    pick=rand;
    while pick==0
        pick=rand;
    end
    for j=1:sizepop
        pick=pick-pselect(j);
        if pick<0
            index=[index j];
            break;
        end
    end
end
%注意：在转sizepop次轮盘的过程中，有可能会重复选择某些染色体
individuals.chrom=individuals.chrom(index,:);
individuals.fitness=individuals.fitness(index);
individuals.concentration=individuals.concentration(index);
individuals.excellence=individuals.excellence(index);
ret=individuals;
end


        
