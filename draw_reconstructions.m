function draw_reconstructions(P_orig, P_rec)
hold on;
for i = 1 : size(P_orig,2)
    plot([P_orig(1,i), P_rec(1,i) ] , [P_orig(2,i), P_rec(2,i) ],'k') ;
end

plot(P_orig(1,:), P_orig(2,:),'rx') ;
plot(P_rec(1,:), P_rec(2,:),'bo') ;
end