%IG 15/10/12 read names for 160 balls
clear Name
cd('C:\Users\Ithabi\Documents\paola\scripts160\160rois')
A=dir('*.mat');
Name = []
for i=1:length(A)
Name{i,:} = A(i,1).name;
end
