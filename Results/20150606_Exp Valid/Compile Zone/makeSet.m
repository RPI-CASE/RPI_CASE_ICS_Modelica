function [ trainSet, validSet ] = makeSet( size_1,size_2 )


p = randperm(size_1);

trainSet = p(1:size_2);
validSet = p(size_2+1:size_1);
data



end

