function [CON]=majorlist_all(average_conn, textmeasure, now, name, nchan, s, crank)
% DEFINE LIST WITH 10 or 15 (Crank) MOST ACTIVE ELECTRODE COUPLES 

%average_conn=tril(average_conn,-1); 
% LOWER LEFT diagonal of array- since  partial correlation is symmetrical
% Lower left gives receiving, Upper right gives sending. 
%crank=15; % the top channels (how many we want)
[Megisti,ind]=sort(average_conn(:),'descend');
% In general 'ind' is the number refering to the values inside the array 
% For example, if the first element of Megisti (the maximum) is
% Megisti(1)=0.9052 and the
% ind(1)=298, then average_conn(298)=Megisti. 
% This one index refers to the 2-D (i,j) index of an array. Matlab counts 
% column-wise (i think).. 
% Find the non-zeros in Megisti. We have a lot of zeros because, it is onlu
% the lower part below the diagonal.
[r, c, v]=find(Megisti);% [row, columns, logicalvalue]=find non zeros in Megisti. Correction 2012 for elimination of zeros
Megisti=Megisti(r);

% Take the 15 first (crank=15) of Megisti and of ind.
Megisti = Megisti(1:crank); ind=ind(1:crank);
% Get for this one index to the 2-D index
[row col] = ind2sub(size(average_conn),ind);
couple_conn={};

% create the list with the most active electrode couples
for k=1:crank, couple_conn{k}=[s{row(k)} '-' s{col(k)}]; end;
CON.couple_conn=couple_conn;

% this is the values of the connectivity or correlation coefficient for the most active
% channels
for kk=1:crank, couple_conn_values(kk)=Megisti(kk); end;
CON.couple_conn_values=couple_conn_values;

% Send the results to excel file 
stempp=['MostCouples-' textmeasure]; % do not delete this!!!!
xlswrite(stempp, {name}, 'Sheet1', 'A1:A1')
titles={'most strong couples'};
xlswrite(stempp, (titles), 'Sheet1', 'A2:A2')
xlswrite(stempp,couple_conn, 'Sheet1', 'B2')
xlswrite(stempp,couple_conn_values, 'Sheet1', 'B3')

% Send the results to excel file, new Dec 2016
% by making a table and then exporting to excel
% Need to try this on a windows machine. 
%  A3=table((couple_conn')', [couple_conn_values']')%, 'VariableNames', {'couples','values'});
% filename_to_save_xls=['MostCouples-dec16-' textmeasure '.csv'];
% writetable(A3, filename_to_save_xls);



%commented below dec16
% plot only those with increase more than half the max value
% average_conn_pos=zeros(nchan, nchan);
% for hh=1:nchan
%     for kk=1:nchan
%         max1=max(max(average_conn))/2;
%         if average_conn(kk,hh)>max1; %% this threshold could change depending on average resutls
%             average_conn_pos(kk,hh)=average_conn(kk,hh);
%         else
%             average_conn_pos(kk,hh)=0;
%         end
%     end
% end

% figure;imagesc(average_conn_pos); title([textmeasure ': connectivity above threshold']);
% set(gca,'Ytick', 1:nchan); set(gca, 'XTick', 1:nchan); set(gca, 'YTickLabel', s); set(gca, 'XTickLabel', s);
% axis xy; axis tight; colorbar('location','EastOutside');



