load('Extracted/Random/depthstrained.mat');

figure();
subplot(2,1,1);

bar(1000*[trainmeansd05(1) valmeansd05(1) testmeansd05(1);...
    trainmeansd10(1) valmeansd10(1) testmeansd10(1);...
    trainmeansd15(1) valmeansd15(1) testmeansd15(1);...
    trainmeansd20(1) valmeansd20(1) testmeansd20(1)]);
ylabel('xy error (mm)');
set(gca,'XTickLabel',{'5mm';'10mm';'15mm';'20mm'});
legend({'Training'; 'Validation'; 'Test'});

subplot(2,1,2);

bar(1000*[trainmeansd05(2) valmeansd05(2) testmeansd05(2);...
    trainmeansd10(2) valmeansd10(2) testmeansd10(2);...
    trainmeansd15(2) valmeansd15(2) testmeansd15(2);...
    trainmeansd20(2) valmeansd20(2) testmeansd20(2)]);
ylabel('xy error (mm)');
set(gca,'XTickLabel',{'5mm';'10mm';'15mm';'20mm'});
legend({'Training'; 'Validation'; 'Test'});