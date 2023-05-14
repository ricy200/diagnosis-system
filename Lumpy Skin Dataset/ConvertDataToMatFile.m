function convertDataToMatFile ()

   % T = readtable("Lumpy skin disease data.csv")
   % x_values = [];
   % x_values_index1 = 0;
    
    symptoms_ls={}; 
    symptoms_ls_index1=0;

    all_symptoms_ls={}; 
    all_symptoms_ls_index1=0; 

    current_file = fopen("Lumpy skin disease data.csv");

    line=fgetl(current_file);

    current_data=strsplit(line,',');

    for i=1:size(current_data,2)
            if ~isempty(deblank(current_data{1,i}))
                all_symptoms_ls_index1=all_symptoms_ls_index1+1; %increase index
                all_symptoms_ls{all_symptoms_ls_index1,1}=deblank(current_data{1,i}); 
            end
    end

    fclose(current_file);

    current_file = fopen("Lumpy skin disease data.csv");

    line=fgetl(current_file);

    while ~feof(current_file)

        line=fgetl(current_file); %get current line in the file
        current_data=strsplit(line,',');

        symptoms_ls_index1=symptoms_ls_index1 + 1;

        for i=1:size(current_data, 2)
            symptoms_ls(symptoms_ls_index1, i)=current_data(1,i);
        end
 
        % x_values_index1=x_values_index1+1; 
        % x_values{x_values_index1,1}=deblank(current_data{1,1});

    end
    fclose(current_file);

    save('Lumpy skin disease data.mat', 'symptoms_ls', 'all_symptoms_ls');

end
