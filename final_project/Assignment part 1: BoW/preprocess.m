j=0;
for i=labels
    ysplit{i}=zeros(2000,1);
    ysplit{i}(j+1:j+400)=1;
    j=j+400;
end