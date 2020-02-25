function [newMoveFlag, newTrFlag, newIterFlag, newM] = Schema101Sin(M, moveFlag, trFlag,iterFlag)

newMoveFlag=moveFlag;
newTrFlag=trFlag;
newIterFlag=iterFlag;
n=sqrt(numel(M));
newM=zeros(n,n);

tran_up=0;
tran_dn=0;

for i=1:n
    for j=1:n
        mov_up=0;
        mov_dn=0;
        mov_rt=0;
        mov_lt=0;
        
        tran_up=0;
        tran_dn=0;
        tran_rt=0;
        tran_lt=0;
        
        s_up=0;
        s_dn=0;
        s_rt=0;
        s_lt=0;
        
        
        
        switch i
            case 1
                mov_up = moveFlag(n,j);
                tran_up = trFlag(n,j);
                s_up = M(n,j);
                
                mov_dn = moveFlag(i+1,j);
                tran_dn = trFlag(i+1,j);
                s_dn = M(i+1,j);
            case n
                mov_up = moveFlag(i-1,j);
                tran_up = trFlag(i-1,j);
                s_up = M(i-1,j);
                
                mov_dn = moveFlag(1,j);
                tran_dn = trFlag(1,j);
                s_dn = M(1,j);
            otherwise
                mov_up = moveFlag(i-1,j);
                tran_up = trFlag(i-1,j);
                s_up = M(i-1,j);
                
                mov_dn = moveFlag(i+1,j);
                tran_dn = trFlag(i+1,j);
                s_dn = M(i+1,j);
        end
        
        switch j
            case 1
                mov_lt = moveFlag(i,n);
                tran_lt = trFlag(i,n);
                s_lt = M(i,n);
                
                mov_rt = moveFlag(i,j+1);
                tran_rt = trFlag(i,j+1);
                s_rt = M(i,j+1);
            case n
                mov_lt = moveFlag(i,j-1);
                tran_lt = trFlag(i,j-1);
                s_lt = M(i,j-1);
                
                mov_rt = moveFlag(i,1);
                tran_rt = trFlag(i,1);
                s_rt = M(i,1);
            otherwise
                mov_lt = moveFlag(i,j-1);
                tran_lt = trFlag(i,j-1);
                s_lt = M(i,j-1);
                
                mov_rt = moveFlag(i,j+1);
                tran_rt = trFlag(i,j+1);
                s_rt = M(i,j+1);
        end
        
        %условия сдвигов
        switch moveFlag(i,j)
                
            case -1
                if(mov_up==-1 && mov_dn==-1)
                    newM(i,j)=s_up;
                else
                    newM(i,j)=s_rt;
                end
                
            case 0
                newM(i,j)=M(i,j);
            
            case 1
                if(mov_up==1 && mov_dn==1)
                    newM(i,j)=s_dn;
                else
                    newM(i,j)=s_lt;
                end
                
        end
        %конец условий сдвигов
        
        %условия изменения компоненты транспонирования
        if(mov_dn==mov_up && mov_up==moveFlag(i,j))
            
            switch moveFlag(i,j)
            
                case {-1, 1}
                    newTrFlag(i,j)=2;
            
                case 0
                    
                    switch newIterFlag
                        
                        case 1
                            
                            if(mov_rt~=-1) 
                                newTrFlag(i,j)=1;
                            else
                                newTrFlag(i,j)=3;
                            end
                            
                        case {0, 2}
                            
                            if(mov_lt==-1)
                                newTrFlag(i,j)=1;
                            end
                            
                            if(mov_lt==1)
                                newTrFlag(i,j)=3;
                            end
                            
                        case 3
                            
                            if(mov_rt~=1) 
                                newTrFlag(i,j)=3;
                            else
                                newTrFlag(i,j)=1;
                            end
                            
                    end
                    
            end
            
        else
            
            switch moveFlag(i,j)
            
                case {-1, 1}
                    newTrFlag(i,j)=2;
            
                case 0
                    
                    switch newIterFlag
                        
                        case 1
                            
                            if(mov_dn~=-1) 
                                newTrFlag(i,j)=1;
                            else
                                newTrFlag(i,j)=3;
                            end
                            
                        case {0, 2}
                            
                            if(mov_up==-1)
                                newTrFlag(i,j)=1;
                            end
                            
                            if(mov_up==1)
                                newTrFlag(i,j)=3;
                            end
                            
                        case 3
                            
                            if(mov_dn~=1) 
                                newTrFlag(i,j)=3;
                            else
                                newTrFlag(i,j)=1;
                            end
                            
                    end
                    
            end
            
        end
        %конец условий изменения компоненты транспонирования
        
        %условия изменения компоненты перемещения
        switch trFlag(i,j)
            
            case 1
                newMoveFlag(i,j)=1;
            
            case 2
                newMoveFlag(i,j)=0;
            
            case 3
                newMoveFlag(i,j)=-1;
        end
        %конец условий изменения компоненты перемещения
    end
end

% изменения компоненты итераций
if(tran_up==tran_dn &&tran_dn==trFlag(i,j))
   newIterFlag=mod(newIterFlag+1,4);
end

end

