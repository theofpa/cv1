A=randi(100,100);
for i=2:99
    for j=2:99
        B(i,j)=mean(mean(A(i-1:i+1,j-1:j+1)));
    end
end