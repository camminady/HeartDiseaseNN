function driver_trainHeartDisease


N = 1000;
for i=1:N
    i
    [kappatest,kappatrain] = trainHeartDisease;
    Kappatrain(i) = kappatrain;
    Kappatest(i) = kappatest;
end
save
figure
histogram(Kappatrain,20);
hold on
histogram(Kappatest,20);
legend('train','test');
keyboard



end
