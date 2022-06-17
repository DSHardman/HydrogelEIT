interest = [13 16 23 24 38 47 109 112 115:120 133 147 152 181];
%interest = 1:192;

for i = 1:length(interest)
    subplot(2,3,1);
    responses = 1./abs(line1(1:2:end, interest(i)) - line1(2:2:end, interest(i)));
    bar(1:15, responses);
    title('Undamaged');
    
    subplot(2,3,2);
    responses = 1./abs(cut1(1:2:end, interest(i)) - cut1(2:2:end, interest(i)));
    bar(1:15, responses);
    title('Cut');
    
    subplot(2,3,3);
    responses = 1./abs(heal1(1:2:end, interest(i)) - heal1(2:2:end, interest(i)));
    bar(1:15, responses);
    title('Healed');

    subplot(2,3,4);
    responses = 1./abs(line2(1:2:end, interest(i)) - line2(2:2:end, interest(i)));
    bar(1:15, responses);
    
    subplot(2,3,5);
    responses = 1./abs(cut2(1:2:end, interest(i)) - cut2(2:2:end, interest(i)));
    bar(1:15, responses);
    
    subplot(2,3,6);
    responses = 1./abs(heal2(1:2:end, interest(i)) - heal2(2:2:end, interest(i)));
    bar(1:15, responses)

    sgtitle("Sensor " + string(interest(i)));
    pause()
end