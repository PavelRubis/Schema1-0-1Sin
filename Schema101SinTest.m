% clear;
clc;

el=1;
n=11;
M=zeros(n,n);
moveFlag=zeros(n,n);
trFlag=zeros(n,n);
iterFlag=1;

moveFlag(:,2:4:n)=1;
moveFlag(:,1:2:n)=0;
moveFlag(:,4:4:n)=-1;

trFlag(2:4:n,:)=1;
trFlag(1:2:n,:)=2;
trFlag(4:4:n,:)=3;

oldMoveFlag=moveFlag;
newMoveFlag=moveFlag;
oldTrFlag=trFlag;
newTrFlag=trFlag;
newIterFlag=iterFlag;

for j=1:n
    for i=1:n
        M(i,j)=el;
        el=el+1;
    end
end

oldM = M;
newM=zeros(n,n);

% periods=[]

period= 0;
while (~(isequal(oldM,M)&& period~=0 && ((mod(period,6))==0) && isequal(oldMoveFlag,newMoveFlag) && isequal(oldTrFlag,newTrFlag) && isequal(iterFlag,newIterFlag)))
    
    [newMoveFlag, newTrFlag, newIterFlag, newM] = Schema101Sin(M, moveFlag, trFlag,iterFlag);
    moveFlag=newMoveFlag;
    trFlag=newTrFlag;
    iterFlag=newIterFlag;
    M=newM;
    
    period=period+1;
end
n
period=period/8
periods=[periods period];