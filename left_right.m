function [corgofL corgofR thr]=left_right(mcor, numRight, numLeft, XYZ)
% s=resultsALL.s;
nchan=length(XYZ);
corgofR=zeros(nchan);
corgofL=zeros(nchan);
corgoall=zeros(nchan);
corgofR(numRight, numRight)=mcor(numRight,numRight);
corgofL(numLeft, numLeft)=mcor(numLeft,numLeft); 
corgoall=(corgofR+corgofL)./2;
thr=(3/4)*(max(squeeze(max(corgoall))));% to miso tou megistou