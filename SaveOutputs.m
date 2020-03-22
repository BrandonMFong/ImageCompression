% Refer to Save.json to configure what variable to save
% Save
%   VariableName: Name of the variable in the workspace
%   Path: Path to save to.  Can be full path or path start from this project folder
%   Type: Constant, Matrix, or Image.  Must specify or variable will not be saved
savevar = jsondecode(fileread('Save.json'));
for i = 1:size(savevar.Save,1)
    if savevar.Save(i).Type == "Constant"
        save(savevar.Save(i).Path,savevar.Save(i).VariableName,'-ascii')
    elseif savevar.Save(i).Type == "Matrix"
        file = fopen(savevar.Save(i).Path,'wt');
        eval(['val = ',savevar.Save(i).VariableName,';']);
        for i = 1:size(val,1)
            fprintf(file,'%g,',val(i,:));
            fprintf(file,'\n');
        end
        fclose(file);
    elseif savevar.Save(i).Type == "Image"
        eval(['val = ',savevar.Save(i).VariableName,';']);
        imwrite(val,savevar.Save(i).Path);
    else
        fprintf('%s not saved into file, please check Save.json if Type is specified.', savevar.Save(i).VariableName); 
    end
end

% file = fopen('./Outputs/Inverse_QDCT_Cb.csv','wt');
% eval(['val = ','Inverse_QDCT_Cb',';']);
% for ii = 1:size(val,1)
%     fprintf(file,'%g,',val(ii,:));
%     fprintf(file,'\n');
% end
% fclose(file)

% imwrite(DCTBlock1,'./Outputs/DCTBlock1.jpg')
% imwrite(DCTBlock2,'./Outputs/DCTBlock2.jpg')
% imwrite(NewImgYCbCr,'./Outputs/NewImgYCbCr.jpg')
% imwrite(NewImgRGB,'./Outputs/NewImgRGB.jpg')
% imwrite(DiffImg,'./Outputs/DiffImg.jpg')