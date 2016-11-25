%% 12 July 2016,

% Ingrid change this:
%DOI1='/Users/mstavrin/Documents/MATLAB/CNV/ANALYZED_DATASETS';
DOI1='/Volumes/Secure_HDD/CNV KONNEKTIVITET_2016 fortsettelse av prosjekt fra 2012/CNV_folders fromMaria/CNV/ANALYZED_DATASETS_laterale';
%'D:\RIKSHOSPITALET\CNV_RIKS\ANALYZED DATASETS_cube\NEW\Second_component_controls\'
%DOI2='D:\OFC\ANALYZED_DATASETS_cube\Second_component_OFC\'
% index1=1;
% index2=3;
textmeasuresall={'DTFdelta','DTFtheta','DTFalpha','DTFbeta','DTFgamma1'}
thismoment=datestr(now); 
for jj=1:length(thismoment); if ( thismoment(jj)==':' || thismoment(jj)==' '); thismoment(jj)='-';end; end
Brain_areas={'F';'C';'P'}
titles={'RGO', 'RNOGO', 'LGO', 'LNOGO'}

for kkk=1:3
    for jjj=1:3
        if kkk~=jjj
            index1=kkk;
            index2=jjj;
            for qq=1:length(textmeasuresall)
                textmeasure=textmeasuresall{qq}
                name=[Brain_areas(index1) '-' Brain_areas(index2)]
                cd(DOI1)
                load STATSFINAL  
                ND=length(STATSFINAL)+1;
                mkdir('stats')
                cd('stats')
                   % right hemisphere
                   % 2016 WHY -2??? TODO
                for kk=1:(ND-2); PFRGoLaterals(kk,:)=STATSFINAL(kk).(textmeasure).Go_right_areas(index1,index2);end
                for kk=1:(ND-2); PFRNOGOLaterals(kk,:)=STATSFINAL(kk).(textmeasure).NoGo_right_areas(index1,index2); end
                % left hemisphere
                for kk=1:(ND-2); PFLGoLaterals(kk,:)=STATSFINAL(kk).(textmeasure).Go_left_areas(index1,index2); end
                for kk=1:(ND-2); PFLNOGOLaterals(kk,:)=STATSFINAL(kk).(textmeasure).NoGo_left_areas(index1,index2); end
                for kk=1:(ND-2); nameLaterals{kk}=STATSFINAL(kk).(textmeasure).name(1:5); end
                clear kk
%         %% now go to the patients data and DOI2 - Commend start 
%                 cd(DOI2)
%                 load STATSFINAL 
%                % right hemisphere
%                 for kk=1:(ND-2); PFRGoPa(kk,:)=STATSFINAL(kk).(textmeasure).Go_right_areas(index1,index2); end
%                 for kk=1:(ND-2); PFRNOGOPa(kk,:)=STATSFINAL(kk).(textmeasure).NoGo_right_areas(index1,index2); end
%             % left hemisphere
%                 for kk=1:(ND-2); PFLGoPa(kk,:)=STATSFINAL(kk).(textmeasure).Go_left_areas(index1,index2); end
%                 for kk=1:(ND-2); PFLNOGOPa(kk,:)=STATSFINAL(kk).(textmeasure).NoGo_left_areas(index1,index2); end
%                 
                 PFRGof=[PFRGoLaterals];
                 PFRNOGOf=[PFRNOGOLaterals];
                 PFLGof=[PFLGoLaterals];
                 PFLNOGOf=[PFLNOGOLaterals];
%                array_final=[PFRGof PFRNOGOf PFLGof PFLNOGOf PFRGo PFRNOGO PFLGo PFLNOGO];
                 array_final=[PFRGof PFRNOGOf PFLGof PFLNOGOf];
                titles={[textmeasure 'RGO' num2str(index1) num2str(index2) ], [textmeasure 'RNOGO' num2str(index1) num2str(index2) ], [textmeasure  'LGO' num2str(index1) num2str(index2)], [textmeasure 'LNOGO' num2str(index1) num2str(index2) ]}
                cd(DOI1)
                for kk=1:(ND-2)
                    nameLaterals{kk}=STATSFINAL(kk).(textmeasure).name(1:5);
                end
%% Comment end
                cd(DOI1)
                ARRAY_FINAL(qq).array_final=array_final;
                stempp=['Array' num2str(index1) '-' num2str(index2)]
                stemppsheet=textmeasure;
                cd('stats')
                xlswrite(stempp, {thismoment}, stemppsheet, 'A1:A1');
                xlswrite(stempp, textmeasure, stemppsheet, 'B1:B1');
                xlswrite(stempp, num2str(index1), stemppsheet, 'C1:C1');
                xlswrite(stempp, num2str(index2), stemppsheet, 'D1:D1');
                xlswrite(stempp, {'Subject'}, stemppsheet, 'A2:A2');
                xlswrite(stempp, {'Group'}, stemppsheet, 'B2:B2');
                xlswrite(stempp, titles(1), stemppsheet, 'C2:C2');
                xlswrite(stempp, titles(2), stemppsheet, 'D2:D2');
                xlswrite(stempp, titles(3), stemppsheet, 'E2:E2');
                xlswrite(stempp, titles(4), stemppsheet, 'F2:F2');
                
                Group(1:(ND-2))=3; %Group((ND-1):2*(ND-2))=2;
                nameall=[nameLaterals'];
                xlswrite(stempp, Group', stemppsheet, 'B3');
                xlswrite(stempp, nameall, stemppsheet, 'A3');
                xlswrite(stempp, array_final, stemppsheet, 'C3');
                clear STATSFINAL kk array_final PFRGof PFRNOGOf PFLGof PFLNOGOf PFRGoCo PFRGoPa PFRNOGOCo PFRNOGOPa PFLGoPa PFLNOGOPa
            end

        end
    end
end

cd(DOI1)
mkdir('stats')
save ARRAY_FINAL ARRAY_FINAL
